let undefined ?(message = "Undefined") _ = failwith message

let const : 'a -> ('b -> 'a) =
  fun x _ -> x

external id : 'a -> 'a = "%identity"

let (%>) : ('a -> 'b) -> ('b -> 'c) -> ('a -> 'c) =
  fun g f x -> f (g x)

let (%) : ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c) =
  fun g f x -> g (f x)

let flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c) =
  fun f x y -> f y x

let curry : ('a * 'b -> 'c) -> ('a -> ('b -> 'c)) =
  fun f x y -> f (x, y)

let uncurry : ('a -> ('b -> 'c)) -> ('a * 'b -> 'c) =
  fun f (x, y) -> f x y

let tap f x : ('a -> unit) -> ('a -> 'a)
  = f x; x

external (@@) : ('a -> 'b) -> ('a -> 'b) = "%apply"

external (|>) : 'a -> (('a -> 'r) -> 'r) = "%revapply"

module type SEMIGROUP = sig
  type t
  val op : t -> t -> t
end

module type MONOID = sig
  include SEMIGROUP
  val unit : t
end

module type SEMIRING = sig
  type t
  val zero : t
  val add : t -> t -> t
  val one : t
  val mul : t -> t -> t
end

module Profunctor = struct
  module type SIG = sig
    type (-'a, +'b) p
    val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) p -> ('a, 'd) p)
  end
  module Manifest (T : SIG) = struct
    let lmap : ('a -> 'b) -> (('b, 'c) T.p -> ('a, 'c) T.p)
      = fun f -> T.dimap f id
    let rmap : ('c -> 'd) -> (('b, 'c) T.p -> ('b, 'd) T.p)
      = fun f -> T.dimap id f
  end
end

module type FUNCTOR =  sig
  type +'a t
  val map : ('a -> 'b) -> ('a t -> 'b t)
end

module type OPFUNCTOR = sig
  type -'a t
  val map : ('a -> 'b) -> ('b t -> 'a t)
end

module type SEMICATEGORY = sig
  include Profunctor.SIG
  val cmp : ('b, 'c) p -> ('a, 'b) p -> ('a, 'c) p
end

module type CATEGORY = sig
  include Profunctor.SIG
  val idn : ('a, 'a) p
end

module type APPLY = sig
  include FUNCTOR
  val apply : ('a -> 'b) t -> ('a t -> 'b t)
end

module type APPLICATIVE = sig
  include APPLY
  val pure : 'a -> 'a t
end

module type BIND = sig
  include APPLY
  val bind : 'a t -> ('a -> 'b t) -> 'b t
end

module type MONAD = sig
  include APPLICATIVE
  include (BIND with type 'a t := 'a t)
end

module type EXTEND = sig
  include FUNCTOR
  val extend : ('a t -> 'b) -> ('a t -> 'b t)
end

module type COMONAD = sig
  include EXTEND
  val extract : 'a t -> 'a
end

module type FOLDABLE = sig
  type 'a t
  val foldr : ('a -> 'b -> 'b) -> ('b -> 'a t -> 'b)
  val foldl : ('b -> 'a -> 'b) -> ('b -> 'a t -> 'b)
  val foldMap : (module MONOID with type t = 'm) -> ('a -> 'm) -> ('a t -> 'm)
end

module SemigroupIntAdditive : (SEMIGROUP with type t = int) = struct
  type t = int
  let op x y = x + y
end
module SemigroupIntMultiplicative : (SEMIGROUP with type t = int) = struct
  type t = int
  let op x y = x * y
end
module MonoidIntAdditive : (MONOID with type t = int) = struct
  include SemigroupIntAdditive
  let unit = 0
end
module MonoidIntMultiplicative : (MONOID with type t = int) = struct
  include SemigroupIntMultiplicative
  let unit = 1
end
module SemiringInt : (SEMIRING with type t = int) = struct
  type t = int
  let zero = MonoidIntAdditive.unit
  let add x y = MonoidIntAdditive.op x y
  let one = MonoidIntMultiplicative.unit
  let mul x y = MonoidIntMultiplicative.op x y
end

module ProfunctorArrow = struct
  module Core : (Profunctor.SIG with type (-'a, +'b) p = 'a -> 'b) = struct
    type (-'a, +'b) p = 'a -> 'b
    let dimap f g h = g % h % f
  end
  include Core
  include Profunctor.Manifest(Core)
end
