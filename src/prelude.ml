(*
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
*)

module Sig = struct
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

  module type MODULOSEMIRING = sig
    include SEMIRING
    val div : t -> t -> t
    val modu : t -> t -> t
  end

  module type RING = sig
    include SEMIRING
    val sub : t -> t -> t
  end

  module type DIVISIONRING = sig
    include RING
    include (MODULOSEMIRING with type t := t)
  end

  module type PROFUNCTOR = sig
    type (-'a, +'b) p
    val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) p -> ('a, 'd) p)
  end

  module type FUNCTOR =  sig
    type +'a t
    val map : ('a -> 'b) -> ('a t -> 'b t)
  end

  module type OPFUNCTOR = sig
    type -'a t
    val map : ('a -> 'b) -> ('b t -> 'a t)
  end

  module type SEMIGROUPOID = sig
    include PROFUNCTOR
    val compose : ('b, 'c) p -> ('a, 'b) p -> ('a, 'c) p
  end

  module type CATEGORY = sig
    include PROFUNCTOR
    val id : ('a, 'a) p
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
end

module Ext = struct
  module Profunctor = functor (M : Sig.PROFUNCTOR) -> struct
    let lmap : ('a -> 'b) -> (('b, 'c) M.p -> ('a, 'c) M.p)
      = fun f -> M.dimap f (fun x -> x)
    let rmap : ('c -> 'd) -> (('b, 'c) M.p -> ('b, 'd) M.p)
      = fun f -> M.dimap (fun x -> x) f
  end

  module Functor = functor (M : Sig.FUNCTOR) -> struct
    let (<$->) : ('a -> 'b) -> ('a M.t -> 'b M.t) = M.map
    let (<-$>) : 'a M.t -> ('a -> 'b) -> 'b M.t = fun x f -> f <$-> x
    let bang : 'a M.t -> unit M.t = fun x -> (fun _ -> ()) <$-> x
  end

  module Semigroupoid = functor (M : Sig.SEMIGROUPOID) -> struct
    let (%>) : ('b, 'c) M.p -> ('a, 'b) M.p -> ('a, 'c) M.p = M.compose
    let (%<) : ('a, 'b) M.p -> ('b, 'c) M.p -> ('a, 'c) M.p =
      fun f g -> M.compose g f
  end
end

module Semigroup = struct
  module Unit
    : (Sig.SEMIGROUP with type t = unit) =
  struct
    type t = unit
    let op _ _ = ()
  end

  module String
    : (Sig.SEMIGROUP with type t = string) =
  struct
    type t = string
    let op x y = String.concat "" [x; y]
  end

  module Additive = struct
    module Int
      : (Sig.SEMIGROUP with type t = int) =
    struct
      type t = int
      let op x y = x + y
    end

    module Float
      : (Sig.SEMIGROUP with type t = float) =
    struct
      type t = float
      let op x y = x +. y
    end
  end

  module Multiplicative = struct
    module Int
      : (Sig.SEMIGROUP with type t = int) =
    struct
      type t = int
      let op x y = x * y
    end

    module Float
      : (Sig.SEMIGROUP with type t = float) =
    struct
      type t = float
      let op x y = x *. y
    end
  end
end

module Monoid = struct
  module Unit
    : (Sig.MONOID with type t = unit) =
  struct
    include Semigroup.Unit
    let unit = ()
  end

  module Additive = struct
    module Int
      : (Sig.MONOID with type t = int) =
    struct
      include Semigroup.Additive.Int
      let unit = 0
    end

    module Float
      : (Sig.MONOID with type t = float) =
    struct
      include Semigroup.Additive.Float
      let unit = 0.0
    end
  end

  module Multiplicative = struct
    module Int
      : (Sig.MONOID with type t = int) =
    struct
      include Semigroup.Multiplicative.Int
      let unit = 1
    end

    module Float
      : (Sig.MONOID with type t = float) =
    struct
      include Semigroup.Multiplicative.Float
      let unit = 1.0
    end
  end
end

module Semiring = struct
  module Unit
    : (Sig.SEMIRING with type t = unit) =
  struct
    type t = unit
    let zero = ()
    let add _ _ = ()
    let one = ()
    let mul _ _ = ()
  end

  module Int
    : (Sig.SEMIRING with type t = int) =
  struct
    module Add = Monoid.Additive.Int
    module Mul = Monoid.Multiplicative.Int
    type t = int
    let zero = Add.unit
    let add x y = Add.op x y
    let one = Mul.unit
    let mul x y = Mul.op x y
  end

  module Float
    : (Sig.SEMIRING with type t = float) =
  struct
    module Add = Monoid.Additive.Float
    module Mul = Monoid.Multiplicative.Float
    type t = float
    let zero = Add.unit
    let add x y = Add.op x y
    let one = Mul.unit
    let mul x y = Mul.op x y
  end
end

module ModuloSemiring = struct
  module Unit
    : (Sig.MODULOSEMIRING with type t = unit) =
  struct
    include Semiring.Unit
    let div _ _ = ()
    let modu _ _ = ()
  end

  module Int
    : (Sig.MODULOSEMIRING with type t = int) =
  struct
    include Semiring.Int
    let div = (/)
    let modu = (mod)
  end

  module Float
    : (Sig.MODULOSEMIRING with type t = float) =
  struct
    include Semiring.Float
    let div = (/.)
    let modu = mod_float
  end
end

module Ring = struct
  module Unit
    : (Sig.RING with type t = unit) =
  struct
    include Semiring.Unit
    let sub _ _ = ()
  end

  module Int
    : (Sig.RING with type t = int) =
  struct
    include Semiring.Int
    let sub x y = x - y
  end

  module Float
    : (Sig.RING with type t = float) =
  struct
    include Semiring.Float
    let sub x y = x -. y
  end
end

module DivisionRing = struct
  module Unit
    : (Sig.DIVISIONRING with type t = unit) =
  struct
    include Ring.Unit
    include (ModuloSemiring.Unit : Sig.MODULOSEMIRING with type t := t)
  end

  module Float
    : (Sig.DIVISIONRING with type t = float) =
  struct
    include Ring.Float
    include (ModuloSemiring.Float : Sig.MODULOSEMIRING with type t := t)
  end
end

module Profunctor = struct
  module Fn = struct
    module Core
      : (Sig.PROFUNCTOR with type (-'a, +'b) p = 'a -> 'b) =
    struct
      type (-'a, +'b) p = 'a -> 'b
      let dimap f g h = fun x -> g (h (f x))
    end
    include Core
    include Ext.Profunctor(Core)
  end
end
