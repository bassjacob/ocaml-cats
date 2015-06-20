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

(* The Sig module collects structure signatures. *)

module Sig = struct
  module type EXISTS = sig
    include Ty.Sig.Unary.Inv.ELEM
    type t
    type 'r elim = { ap : 'x. 'x el -> 'r }
    val into : 'a el -> t
    val from : t -> 'r elim -> 'r
  end

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
    val modulo : t -> t -> t
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
    include Ty.Sig.Binary.ConPro.ELEM
    val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) el -> ('a, 'd) el)
  end

  module type BIFUNCTOR = sig
    include Ty.Sig.Binary.Cov.ELEM
    val bimap : ('a -> 'b) -> ('c -> 'd) -> (('a, 'c) el -> ('b, 'd) el)
  end

  module type FUNCTOR =  sig
    include Ty.Sig.Unary.Cov.ELEM
    val map : ('a -> 'b) -> ('a el -> 'b el)
  end

  module type OPFUNCTOR = sig
    type -'a t
    val map : ('a -> 'b) -> ('b t -> 'a t)
  end

  module type SEMIGROUPOID = sig
    include PROFUNCTOR
    val compose : ('b, 'c) el -> ('a, 'b) el -> ('a, 'c) el
  end

  module type CATEGORY = sig
    include PROFUNCTOR
    val id : ('a, 'a) el
  end

  module type APPLY = sig
    include FUNCTOR
    val apply : ('a -> 'b) el -> ('a el -> 'b el)
  end

  module type APPLICATIVE = sig
    include APPLY
    val pure : 'a -> 'a el
  end

  module type BIND = sig
    include APPLY
    val bind : 'a el -> ('a -> 'b el) -> 'b el
  end

  module type MONAD = sig
    include APPLICATIVE
    include (BIND with type 'a el := 'a el)
  end

  module type EXTEND = sig
    include FUNCTOR
    val extend : ('a el -> 'b) -> ('a el -> 'b el)
  end

  module type COMONAD = sig
    include EXTEND
    val extract : 'a el -> 'a
  end

  module type FOLDABLE = sig
    include Ty.Sig.Unary.Inv.ELEM
    val foldr : ('a -> 'b -> 'b) -> ('b -> 'a el -> 'b)
    val foldl : ('b -> 'a -> 'b) -> ('b -> 'a el -> 'b)
    val foldMap : (module MONOID with type t = 'm) -> ('a -> 'm) -> ('a el -> 'm)
  end
end

(* The Ext module collects structure extensions as module functors, i.e.,
   derived operations and related functionality. *)

module Ext = struct
  module Semigroup : functor (M : Sig.SEMIGROUP) -> sig
    val (@) : M.t -> M.t -> M.t
  end = functor (M : Sig.SEMIGROUP) -> struct
    let (@) = M.op
  end

  module Semiring : functor (M : Sig.SEMIRING) -> sig
    val ( +@ ) : M.t -> M.t -> M.t
    val ( *@ ) : M.t -> M.t -> M.t
  end = functor (M : Sig.SEMIRING) -> struct
    let ( +@ ) = M.add
    let ( *@ ) = M.mul
  end

  module ModuloSemiring : functor (M : Sig.MODULOSEMIRING) -> sig
    val (/@) : M.t -> M.t -> M.t
    val (%@) : M.t -> M.t -> M.t
  end = functor (M : Sig.MODULOSEMIRING) -> struct
    let (/@) = M.div
    let (%@) = M.modulo
  end

  module Ring : functor (M : Sig.RING) -> sig
    val (-@) : M.t -> M.t -> M.t
    val negate : M.t -> M.t
  end = functor (M : Sig.RING) -> struct
    let (-@) = M.sub
    let negate x = M.zero -@ x
  end

  module Profunctor : functor (M : Sig.PROFUNCTOR) -> sig
    val lmap : ('a -> 'b) -> (('b, 'c) M.el -> ('a, 'c) M.el)
    val rmap : ('c -> 'd) -> (('b, 'c) M.el -> ('b, 'd) M.el)
  end = functor (M : Sig.PROFUNCTOR) -> struct
    let lmap f = M.dimap f (fun x -> x)
    let rmap f = M.dimap (fun x -> x) f
  end

  module Functor : functor (M : Sig.FUNCTOR) -> sig
    val (<$->) : ('a -> 'b) -> ('a M.el -> 'b M.el)
    val (<-$>) : 'a M.el -> ('a -> 'b) -> 'b M.el
    val bang : 'a M.el -> unit M.el
  end = functor (M : Sig.FUNCTOR) -> struct
    let (<$->) = M.map
    let (<-$>) x f = f <$-> x
    let bang x = (fun _ -> ()) <$-> x
  end

  module Semigroupoid : functor (M : Sig.SEMIGROUPOID) -> sig
    val (%>) : ('b, 'c) M.el -> ('a, 'b) M.el -> ('a, 'c) M.el
    val (%<) : ('a, 'b) M.el -> ('b, 'c) M.el -> ('a, 'c) M.el
  end = functor (M : Sig.SEMIGROUPOID) -> struct
    let (%>) = M.compose
    let (%<) f g = M.compose g f
  end

  module Apply : functor (M : Sig.APPLY) -> sig
    val (<*>) : ('a -> 'b) M.el -> ('a M.el -> 'b M.el)
  end = functor (M : Sig.APPLY) -> struct
    let (<*>) = M.apply
  end

  module Bind : functor (M : Sig.BIND) -> sig
    val (>>=) : 'a M.el -> ('a -> 'b M.el) -> 'b M.el
  end = functor (M : Sig.BIND) -> struct
    let (>>=) = M.bind
  end

  module Monad : functor (M : Sig.MONAD) -> sig
    val ap : ('a -> 'b) M.el -> ('a M.el -> 'b M.el)
  end = functor (M : Sig.MONAD) -> struct module E = Bind(M);; open M;; open E;;
    let ap mf mx = mf >>= fun f -> mx >>= fun x -> pure (f x)
  end
end

(* Individual structure instances are grouped by name and related properties.
   Each instance, such as Semigroup.Unit, is a combination of the core instance
   definition packed along with co-instantiated structure extensions. *)

module Exists : functor (T : Ty.Sig.Unary.Inv.ELEM) -> sig
  include Ty.Sig.Unary.Inv.CODE
  include (Sig.EXISTS with type 'a el := 'a el)
end
  with type 'a el := 'a T.el =
functor (T : Ty.Sig.Unary.Inv.ELEM) -> struct
  include Ty.Def.Unary.Inv(T)
  type 'r elim = { ap : 'x. 'x el -> 'r }
  module Def = struct
    type t = Pack : 'x el -> t
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end

module Semigroup = struct
  module Unit = struct
    module Def
      : (Sig.SEMIGROUP with type t = unit) =
    struct
      type t = unit
      let op _ _ = ()
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module String = struct
    module Def
      : (Sig.SEMIGROUP with type t = string) =
    struct
      type t = string
      let op x y = String.concat "" [x; y]
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Additive = struct
    module Int = struct
      module Def
        : (Sig.SEMIGROUP with type t = int) =
      struct
        type t = int
        let op = (+)
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def
        : (Sig.SEMIGROUP with type t = float) =
      struct
        type t = float
        let op = (+.)
      end
      include Def
      include Ext.Semigroup(Def)
    end
  end

  module Multiplicative = struct
    module Int = struct
      module Def
        : (Sig.SEMIGROUP with type t = int) =
      struct
        type t = int
        let op x y = x * y
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def
        : (Sig.SEMIGROUP with type t = float) =
      struct
        type t = float
        let op x y = x *. y
      end
      include Def
      include Ext.Semigroup(Def)
    end
  end
end

module Monoid = struct
  module Unit = struct
    module Def
      : (Sig.MONOID with type t = unit) =
    struct
      include Semigroup.Unit.Def
      let unit = ()
    end
    include Def
  end

  module Additive = struct
    module Int = struct
      module Def
        : (Sig.MONOID with type t = int) =
      struct
        include Semigroup.Additive.Int.Def
        let unit = 0
      end
      include Def
    end

    module Float = struct
      module Def
        : (Sig.MONOID with type t = float) =
      struct
        include Semigroup.Additive.Float.Def
        let unit = 0.0
      end
      include Def
    end
  end

  module Multiplicative = struct
    module Int = struct
      module Def
        : (Sig.MONOID with type t = int) =
      struct
        include Semigroup.Multiplicative.Int.Def
        let unit = 1
      end
      include Def
    end

    module Float = struct
      module Def
        : (Sig.MONOID with type t = float) =
      struct
        include Semigroup.Multiplicative.Float.Def
        let unit = 1.0
      end
      include Def
    end
  end
end

module Semiring = struct
  module Unit = struct
    module Def
      : (Sig.SEMIRING with type t = unit) =
    struct
      type t = unit
      let zero = ()
      let add _ _ = ()
      let one = ()
      let mul _ _ = ()
    end
    include Def
    include Ext.Semiring(Def)
  end

  module Int = struct
    module Def
      : (Sig.SEMIRING with type t = int) =
    struct
      module Add = Monoid.Additive.Int.Def
      module Mul = Monoid.Multiplicative.Int.Def
      type t = int
      let zero = Add.unit
      let add = Add.op
      let one = Mul.unit
      let mul = Mul.op
    end
    include Def
    include Ext.Semiring(Def)
  end

  module Float = struct
    module Def
      : (Sig.SEMIRING with type t = float) =
    struct
      module Add = Monoid.Additive.Float.Def
      module Mul = Monoid.Multiplicative.Float.Def
      type t = float
      let zero = Add.unit
      let add = Add.op
      let one = Mul.unit
      let mul = Mul.op
    end
    include Def
    include Ext.Semiring(Def)
  end
end

module ModuloSemiring = struct
  module Unit = struct
    module Def
      : (Sig.MODULOSEMIRING with type t = unit) =
    struct
      include Semiring.Unit.Def
      let div _ _ = ()
      let modulo _ _ = ()
    end
    include Def
    include Ext.ModuloSemiring(Def)
  end

  module Int = struct
    module Def
      : (Sig.MODULOSEMIRING with type t = int) =
    struct
      include Semiring.Int.Def
      let div = (/)
      let modulo = (mod)
    end
    include Def
    include Ext.ModuloSemiring(Def)
  end

  module Float = struct
    module Def
      : (Sig.MODULOSEMIRING with type t = float) =
    struct
      include Semiring.Float.Def
      let div = (/.)
      let modulo = mod_float
    end
    include Def
    include Ext.ModuloSemiring(Def)
  end
end

module Ring = struct
  module Unit = struct
    module Def
      : (Sig.RING with type t = unit) =
    struct
      include Semiring.Unit.Def
      let sub _ _ = ()
    end
    include Def
    include Ext.Ring(Def)
  end

  module Int = struct
    module Def
      : (Sig.RING with type t = int) =
    struct
      include Semiring.Int.Def
      let sub = (-)
    end
    include Def
    include Ext.Ring(Def)
  end

  module Float = struct
    module Def
      : (Sig.RING with type t = float) =
    struct
      include Semiring.Float.Def
      let sub = (-.)
    end
    include Def
    include Ext.Ring(Def)
  end
end

module DivisionRing = struct
  module Unit = struct
    module Def
      : (Sig.DIVISIONRING with type t = unit) =
    struct
      include Ring.Unit.Def
      include (ModuloSemiring.Unit.Def : Sig.MODULOSEMIRING with type t := t)
    end
    include Def
  end

  module Float = struct
    module Def
      : (Sig.DIVISIONRING with type t = float) =
    struct
      include Ring.Float.Def
      include (ModuloSemiring.Float.Def : Sig.MODULOSEMIRING with type t := t)
    end
    include Def
  end
end

module Profunctor = struct
  module Fn = struct
    module Def
      : (Sig.PROFUNCTOR with type (-'a, +'b) el = 'a -> 'b) =
    struct
      type (-'a, +'b) el = 'a -> 'b
      let dimap f g h x = g (h (f x))
    end
    include Def
    include Ext.Profunctor(Def)
  end
end

module Bifunctor = struct
  module Product = struct
    module Def
      : (Sig.BIFUNCTOR with type ('a, 'b) el = 'a * 'b) =
    struct
      type ('a, 'b) el = 'a * 'b
      let bimap f g (x, y) = (f x, g y)
    end
    include Def
  end
end

module Functor = struct
  module List = struct
    module Def
      : (Sig.FUNCTOR with type +'a el = 'a list) =
    struct
      type +'a el = 'a list
      let map = List.map
    end
    include Def
    include Ext.Functor(Def)
  end
end

module Semigroupoid = struct
  module Fn = struct
    module Def : sig
      include (Sig.SEMIGROUPOID with type (-'a, +'b) el = 'a -> 'b)
    end = struct
      include Profunctor.Fn.Def
      let compose g f x = g (f x)
    end
    include Def
    include Ext.Semigroupoid(Def)
  end
end

module Category = struct
  module Fn = struct
    module Def : sig
      include (Sig.CATEGORY with type (-'a, +'b) el = 'a -> 'b)
    end = struct
      include Profunctor.Fn.Def
      let id x = x
    end
    include Def
  end
end

(** Examples **)

(* Existentials for List functor *)
let ex0 () : int = let module E = Exists(Functor.List) in
  let pkg = E.into [0; 1; 2; 3; 4] in (* pack *)
  E.from pkg { E.ap = List.length }   (* elim *)

(* Bifunctor for product *)
let ex1 () : int * string =
  Bifunctor.Product.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Semigroupoid for (->) *)
let ex2 () : int = let open Semigroupoid.Fn in
  ((fun x -> x + 1) %> (fun x -> x * 2)) 10
