let undefined ?(message = "Undefined") _ = failwith message

external (@@) : ('a -> 'b) -> ('a -> 'b) = "%apply"
external (|>) : 'a -> (('a -> 'r) -> 'r) = "%revapply"

type void = Ambient.Initial.t
type ('a, 'b) sum = ('a, 'b) Ambient.Coproduct.t

(* The Sig module collects structure signatures. *)

module Sig = struct
  module type EXISTS = sig
    include Ty.Sig.Unary.Invariant.CODE
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
    include MODULOSEMIRING with type t := t
  end

  module type FUNCTOR = sig
    include Ty.Sig.Unary.Covariant.CODE
    val map : ('a -> 'b) -> ('a el -> 'b el)
  end

  module type BIFUNCTOR = sig
    include Ty.Sig.Binary.Covariant.CODE
    val bimap : ('a -> 'b) -> ('c -> 'd) -> (('a, 'c) el -> ('b, 'd) el)
  end

  module type PRESHEAF = sig
    include Ty.Sig.Unary.Contravariant.CODE
    val premap : ('a -> 'b) -> ('b el -> 'a el)
  end

  module type PROFUNCTOR = sig
    include Ty.Sig.Binary.ContraCovariant.CODE
    val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) el -> ('a, 'd) el)
  end

  module type SEMIGROUPOID = sig
    include PROFUNCTOR
    val compose : ('b, 'c) el -> ('a, 'b) el -> ('a, 'c) el
  end

  module type CATEGORY = sig
    include PROFUNCTOR
    val id : ('a, 'a) el
  end

  module type PRODUCT = sig
    include BIFUNCTOR
    val fst : ('a, 'b) el -> 'a
    val snd : ('a, 'b) el -> 'b
    val pair : ('x -> 'a) -> ('x -> 'b) -> ('x -> ('a, 'b) el)
  end

  module type COPRODUCT = sig
    include BIFUNCTOR
    val inl : 'a -> ('a, 'b) el
    val inr : 'b -> ('a, 'b) el
    val case : ('a -> 'x) -> ('b -> 'x) -> (('a, 'b) el -> 'x)
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
    include BIND
      with type 'a el := 'a el
       and type tc := tc
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
    include Ty.Sig.Unary.Invariant.CODE
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

  module Functor : functor (M : Sig.FUNCTOR) -> sig
    val (<$->) : ('a -> 'b) -> ('a M.el -> 'b M.el)
    val (<-$>) : 'a M.el -> (('a -> 'b) -> 'b M.el)
    val bang : 'a M.el -> unit M.el
  end = functor (M : Sig.FUNCTOR) -> struct
    let (<$->) = M.map
    let (<-$>) x = Ambient.flip (<$->) x
    let bang x = Ambient.bang <$-> x
  end

  module Profunctor : functor (M : Sig.PROFUNCTOR) -> sig
    val lmap : ('a -> 'b) -> (('b, 'c) M.el -> ('a, 'c) M.el)
    val rmap : ('c -> 'd) -> (('b, 'c) M.el -> ('b, 'd) M.el)
  end = functor (M : Sig.PROFUNCTOR) -> struct
    let lmap f = M.dimap f Ambient.id
    let rmap f = M.dimap Ambient.id f
  end

  module Semigroupoid : functor (M : Sig.SEMIGROUPOID) -> sig
    val (%>) : ('b, 'c) M.el -> ('a, 'b) M.el -> ('a, 'c) M.el
    val (%<) : ('a, 'b) M.el -> ('b, 'c) M.el -> ('a, 'c) M.el
  end = functor (M : Sig.SEMIGROUPOID) -> struct
    let (%>) = M.compose
    let (%<) f = Ambient.flip M.compose f
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
   definition packed alongside co-instantiated structure extensions. *)

module Exists : functor (T : Ty.Sig.Unary.Invariant.CODE) -> sig
  include Sig.EXISTS with type 'a el := 'a T.el
end = functor (T : Ty.Sig.Unary.Invariant.CODE) -> struct
  include T
  type 'r elim = { ap : 'x. 'x T.el -> 'r }
  module Def = struct
    type t = Pack : 'x T.el -> t
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end

module Semigroup = struct
  module Unit = struct
    module Def : Sig.SEMIGROUP
      with type t = unit =
    struct
      type t = unit
      let op _ _ = ()
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module String = struct
    module Def : Sig.SEMIGROUP
      with type t = string =
    struct
      type t = string
      let op x y = String.concat "" [x; y]
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Additive = struct
    module Int = struct
      module Def : Sig.SEMIGROUP
        with type t = int =
      struct
        type t = int
        let op = (+)
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def : Sig.SEMIGROUP
        with type t = float =
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
      module Def : Sig.SEMIGROUP
        with type t = int =
      struct
        type t = int
        let op = ( * )
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def : Sig.SEMIGROUP
        with type t = float =
      struct
        type t = float
        let op = ( *. )
      end
      include Def
      include Ext.Semigroup(Def)
    end
  end
end

module Monoid = struct
  module Unit = struct
    module Def : Sig.MONOID
      with type t = Semigroup.Unit.Def.t =
    struct
      include Semigroup.Unit.Def
      let unit = ()
    end
    include Def
  end

  module String = struct
    module Def : Sig.MONOID
      with type t = Semigroup.String.Def.t =
    struct
      include Semigroup.String.Def
      let unit = ""
    end
    include Def
  end

  module Additive = struct
    module Int = struct
      module Def : Sig.MONOID
        with type t = Semigroup.Additive.Int.Def.t =
      struct
        include Semigroup.Additive.Int.Def
        let unit = 0
      end
      include Def
    end

    module Float = struct
      module Def : Sig.MONOID
        with type t = Semigroup.Additive.Float.Def.t =
      struct
        include Semigroup.Additive.Float.Def
        let unit = 0.0
      end
      include Def
    end
  end

  module Multiplicative = struct
    module Int = struct
      module Def : Sig.MONOID
        with type t = Semigroup.Multiplicative.Int.Def.t =
      struct
        include Semigroup.Multiplicative.Int.Def
        let unit = 1
      end
      include Def
    end

    module Float = struct
      module Def : Sig.MONOID
        with type t = Semigroup.Multiplicative.Float.Def.t =
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
    module Def : Sig.SEMIRING
      with type t = unit =
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
    module Def : Sig.SEMIRING
      with type t = int =
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
    module Def : Sig.SEMIRING
      with type t = float =
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
    module Def : Sig.MODULOSEMIRING
      with type t = Semiring.Unit.Def.t =
    struct
      include Semiring.Unit.Def
      let div _ _ = ()
      let modulo _ _ = ()
    end
    include Def
    include Ext.ModuloSemiring(Def)
  end

  module Int = struct
    module Def : Sig.MODULOSEMIRING
      with type t = Semiring.Int.Def.t =
    struct
      include Semiring.Int.Def
      let div = (/)
      let modulo = (mod)
    end
    include Def
    include Ext.ModuloSemiring(Def)
  end

  module Float = struct
    module Def : Sig.MODULOSEMIRING
      with type t = Semiring.Float.Def.t =
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
    module Def : Sig.RING
      with type t = Semiring.Unit.Def.t =
    struct
      include Semiring.Unit.Def
      let sub _ _ = ()
    end
    include Def
    include Ext.Ring(Def)
  end

  module Int = struct
    module Def : Sig.RING
      with type t = Semiring.Int.Def.t =
    struct
      include Semiring.Int.Def
      let sub = (-)
    end
    include Def
    include Ext.Ring(Def)
  end

  module Float = struct
    module Def : Sig.RING
      with type t = Semiring.Float.Def.t =
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
    module Def : Sig.DIVISIONRING
      with type t = Ring.Unit.Def.t =
    struct
      include Ring.Unit.Def
      include (ModuloSemiring.Unit.Def :
        Sig.MODULOSEMIRING with type t := t)
    end
    include Def
  end

  module Float = struct
    module Def : Sig.DIVISIONRING
      with type t = Ring.Float.Def.t =
    struct
      include Ring.Float.Def
      include (ModuloSemiring.Float.Def :
        Sig.MODULOSEMIRING with type t := t)
    end
    include Def
  end
end

module Functor = struct
  module List = struct
    module El = struct type +'a el = 'a list end
    module Def : Sig.FUNCTOR
      with type +'a el = 'a El.el =
    struct
      include Ty.Make.Unary.Covariant(El)
      let map = List.map
    end
    include Def
    include Ext.Functor(Def)
  end
end

module Bifunctor = struct
  module Tuple = struct
    open Ambient
    module El = struct type (+'a, +'b) el = ('a, 'b) Product.t end
    module Def : Sig.BIFUNCTOR
      with type ('a, 'b) el = ('a, 'b) El.el =
    struct
      include Ty.Make.Binary.Covariant(El)
      let bimap f g = let open Product in
        let (%>) = Ambient.compose in pair (f %> fst) (g %> snd)
    end
    include Def
  end

  module Variant = struct
    open Ambient
    module El = struct type (+'a, +'b) el = ('a, 'b) Coproduct.t end
    module Def : Sig.BIFUNCTOR
      with type ('a, 'b) el = ('a, 'b) El.el =
    struct
      include Ty.Make.Binary.Covariant(El)
      let bimap f g = let open Coproduct in
        let (%>) = Ambient.compose in case (inl %> f) (inr %> g)
    end
    include Def
  end
end

module Profunctor = struct
  module Fn = struct
    module El = struct type (-'a, +'b) el = 'a -> 'b end
    module Def : Sig.PROFUNCTOR
      with type (-'a, +'b) el = ('a, 'b) El.el =
    struct
      include Ty.Make.Binary.ContraCovariant(El)
      let dimap f g h = let (%>) = Ambient.compose in g %> h %> f
    end
    include Def
    include Ext.Profunctor(Def)
  end
end

module Semigroupoid = struct
  module Fn = struct
    module Def : Sig.SEMIGROUPOID
      with type (-'a, +'b) el = 'a -> 'b =
    struct
      include Profunctor.Fn.Def
      let compose = Ambient.compose
    end
    include Def
    include Ext.Semigroupoid(Def)
  end
end

module Category = struct
  module Fn = struct
    module Def : Sig.CATEGORY
      with type (-'a, +'b) el = 'a -> 'b =
    struct
      include Profunctor.Fn.Def
      let id = Ambient.id
    end
    include Def
  end
end

module Product = struct
  module Tuple = struct
    open Ambient
    module Def : sig
      include (module type of Bifunctor.Tuple.Def)
      include Sig.PRODUCT
        with type ('a, 'b) el := ('a, 'b) Bifunctor.Tuple.Def.el
         and type tc := Bifunctor.Tuple.Def.tc
    end = struct
      include Bifunctor.Tuple.Def
      include Ambient.Product
    end
    include Def
  end
end

module Coproduct = struct
  module Variant = struct
    open Ambient
    module Def : sig
      include (module type of Bifunctor.Variant.Def)
      include Sig.COPRODUCT
        with type ('a, 'b) el := ('a, 'b) Bifunctor.Variant.Def.el
         and type tc := Bifunctor.Variant.Def.tc
    end = struct
      include Bifunctor.Variant.Def
      include Ambient.Coproduct
    end
    include Def
  end
end

(** Examples **)

(* Existentials for List functor *)
let ex0 () : int = let module E = Exists(Functor.List) in
  let pkg = E.into [0; 1; 2; 3; 4] in (* pack *)
  E.from pkg { E.ap = List.length }   (* elim *)

(* Bifunctor for tuple *)
let ex1 () : int * string =
  Bifunctor.Tuple.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Semigroupoid for (->) *)
let ex2 () : int = let open Semigroupoid.Fn in
  (fun x -> x + 1) %> (fun x -> x * 2) @@ 10
