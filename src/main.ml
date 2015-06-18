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

module Semiring = struct
  module type SIG = sig
    type t
    val zero : t
    val add : t -> t -> t
    val one : t
    val mul : t -> t -> t
  end
  module MakeAdditiveMonoid : functor (T : SIG) -> sig
    include (MONOID with type t := T.t)
  end = functor (T : SIG) -> struct
    type t = T.t
    let unit = T.zero
    let op = T.add
  end
  module MakeMultiplicativeMonoid : functor (T : SIG) -> sig
    include (MONOID with type t := T.t)
  end = functor (T : SIG) -> struct
    type t = T.t
    let unit = T.one
    let op = T.mul
  end
end

module type PROFUNCTOR = sig
  type (-'a, +'b) p
  val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) p -> ('a, 'd) p)
end

module Functor = struct
  module type SIG = sig
    type +'a t
    val map : ('a -> 'b) -> ('a t -> 'b t)
  end
  module Make : functor (Hom: PROFUNCTOR) -> sig
    type dom
    type +'a t = (dom, 'a) Hom.p
    include (SIG with type +'a t := 'a t)
  end = functor (Hom : PROFUNCTOR) -> struct
    type dom
    type +'a t = (dom, 'a) Hom.p
    let map f = Hom.dimap id f
  end
end

module OpFunctor = struct
  module type SIG = sig
    type -'a t
    val map : ('a -> 'b) -> ('b t -> 'a t)
  end
  module Make : functor (Hom : PROFUNCTOR) -> sig
    type cod
    type -'a t = ('a, cod) Hom.p
    include (SIG with type -'a t := 'a t)
  end = functor (Hom : PROFUNCTOR) -> struct
    type cod
    type -'a t = ('a, cod) Hom.p
    let map f = Hom.dimap f id
  end
end

module type SEMICATEGORY = sig
  type (-'a, +'b) hom
  include (PROFUNCTOR with type (-'a, +'b) p := ('a, 'b) hom)
  val cmp : ('b, 'c) hom -> ('a, 'b) hom -> ('a, 'c) hom
end

module type CATEGORY = sig
  type (-'a, +'b) hom
  include (PROFUNCTOR with type (-'a, +'b) p := ('a, 'b) hom)
  val idn : ('a, 'a) hom
end

module type APPLY = sig
  include Functor.SIG
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
  type +'a m
  include (APPLICATIVE with type 'a t := 'a m)
  include (BIND with type 'a t := 'a m)
end

module ProfunctorArrow : PROFUNCTOR = struct
  type (-'a, +'b) p = 'a -> 'b
  let dimap f g h = g % h % f
end
module FunctorArrow = Functor.Make(ProfunctorArrow)
module OpFunctorArrow = OpFunctor.Make(ProfunctorArrow)

module SemiringInt
  : (Semiring.SIG with type t = int) =
struct
  type t = int
  let zero = 0
  let add x y = x + y
  let one = 1
  let mul x y = x * y
end
module MonoidAdditiveInt = Semiring.MakeAdditiveMonoid(SemiringInt)
module MonoidMultiplicativeInt = Semiring.MakeMultiplicativeMonoid(SemiringInt)
