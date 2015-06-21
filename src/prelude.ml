let undefined ?(message = "Undefined") _ = failwith message

external (@@) : ('a -> 'b) -> ('a -> 'b) = "%apply"
external (|>) : 'a -> (('a -> 'r) -> 'r) = "%revapply"

(* The Sig module collects structure signatures. *)

module Sig = struct
  module type EXISTS = sig
    module T : Ty.Sig.Unary.Invariant.CODE
    type t
    type 'r elim = { ap : 'x. 'x T.el -> 'r }
    val into : 'a T.el -> t
    val from : t -> 'r elim -> 'r
  end

  module type SEMIGROUP = sig
    module T : Ty.Sig.Nullary.Invariant.CODE
    val op : T.el -> T.el -> T.el
  end

  module type MONOID = sig
    include SEMIGROUP
    val unit : T.el
  end

  module type SEMIRING = sig
    module T : Ty.Sig.Nullary.Invariant.CODE
    val zero : T.el
    val add : T.el -> T.el -> T.el
    val one : T.el
    val mul : T.el -> T.el -> T.el
  end

  module type MODULOSEMIRING = sig
    include SEMIRING
    val div : T.el -> T.el -> T.el
    val modulo : T.el -> T.el -> T.el
  end

  module type RING = sig
    include SEMIRING
    val sub : T.el -> T.el -> T.el
  end

  module type DIVISIONRING = sig
    include RING
    include MODULOSEMIRING with module T := T
  end

  module type FUNCTOR = sig
    module T : Ty.Sig.Unary.Covariant.CODE
    val map : ('a -> 'b) -> ('a T.el -> 'b T.el)
  end

  module type BIFUNCTOR = sig
    module T : Ty.Sig.Binary.Covariant.CODE
    val bimap : ('a -> 'b) -> ('c -> 'd) -> (('a, 'c) T.el -> ('b, 'd) T.el)
  end

  module type PRESHEAF = sig
    module T : Ty.Sig.Unary.Contravariant.CODE
    val premap : ('a -> 'b) -> ('b T.el -> 'a T.el)
  end

  module type PROFUNCTOR = sig
    module T : Ty.Sig.Binary.ContraCovariant.CODE
    val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) T.el -> ('a, 'd) T.el)
  end

  module type SEMIGROUPOID = sig
    include PROFUNCTOR
    val compose : ('b, 'c) T.el -> ('a, 'b) T.el -> ('a, 'c) T.el
  end

  module type CATEGORY = sig
    include PROFUNCTOR
    val id : ('a, 'a) T.el
  end

  module type PRODUCT = sig
    include BIFUNCTOR
    val fst : ('a, 'b) T.el -> 'a
    val snd : ('a, 'b) T.el -> 'b
    val pair : ('x -> 'a) -> ('x -> 'b) -> ('x -> ('a, 'b) T.el)
  end

  module type COPRODUCT = sig
    include BIFUNCTOR
    val inl : 'a -> ('a, 'b) T.el
    val inr : 'b -> ('a, 'b) T.el
    val case : ('a -> 'x) -> ('b -> 'x) -> (('a, 'b) T.el -> 'x)
  end

  module type APPLY = sig
    include FUNCTOR
    val apply : ('a -> 'b) T.el -> ('a T.el -> 'b T.el)
  end

  module type APPLICATIVE = sig
    include APPLY
    val pure : 'a -> 'a T.el
  end

  module type BIND = sig
    include APPLY
    val bind : 'a T.el -> ('a -> 'b T.el) -> 'b T.el
  end

  module type MONAD = sig
    include APPLICATIVE
    include BIND with module T := T
  end

  module type EXTEND = sig
    include FUNCTOR
    val extend : ('a T.el -> 'b) -> ('a T.el -> 'b T.el)
  end

  module type COMONAD = sig
    include EXTEND
    val extract : 'a T.el -> 'a
  end

  module type FOLDABLE = sig
    module T : Ty.Sig.Unary.Invariant.CODE
    val foldr : ('a -> 'b -> 'b) -> ('b -> 'a T.el -> 'b)
    val foldl : ('b -> 'a -> 'b) -> ('b -> 'a T.el -> 'b)
    val fold_map : (module MONOID with type T.el = 'm)
      -> ('a -> 'm) -> ('a T.el -> 'm)
  end

  module type TRAVERSABLE = sig
    include FUNCTOR
    include FOLDABLE with module T := T
    val traverse : (module APPLICATIVE with type T.tc = 'm)
      -> ('a -> ('b, 'm) Ty.ap) -> ('a T.el -> ('b T.el, 'm) Ty.ap)
    val sequence : (module APPLICATIVE with type T.tc = 'm)
      -> ('a, 'm) Ty.ap T.el -> ('a T.el, 'm) Ty.ap
  end
end

(* The Ext module collects structure extensions as module functors, i.e.,
   derived operations and related functionality. *)

module Ext = struct
  module Semigroup : functor (M : Sig.SEMIGROUP) -> sig
    val (@) : M.T.el -> M.T.el -> M.T.el
  end = functor (M : Sig.SEMIGROUP) -> struct
    let (@) = M.op
  end

  module Semiring : functor (M : Sig.SEMIRING) -> sig
    val ( +@ ) : M.T.el -> M.T.el -> M.T.el
    val ( *@ ) : M.T.el -> M.T.el -> M.T.el
  end = functor (M : Sig.SEMIRING) -> struct
    let ( +@ ) = M.add
    let ( *@ ) = M.mul
  end

  module ModuloSemiring : functor (M : Sig.MODULOSEMIRING) -> sig
    val (/@) : M.T.el -> M.T.el -> M.T.el
    val (%@) : M.T.el -> M.T.el -> M.T.el
  end = functor (M : Sig.MODULOSEMIRING) -> struct
    let (/@) = M.div
    let (%@) = M.modulo
  end

  module Ring : functor (M : Sig.RING) -> sig
    val (-@) : M.T.el -> M.T.el -> M.T.el
    val negate : M.T.el -> M.T.el
  end = functor (M : Sig.RING) -> struct
    let (-@) = M.sub
    let negate x = M.zero -@ x
  end

  module Functor : functor (M : Sig.FUNCTOR) -> sig
    val (<$->) : ('a -> 'b) -> ('a M.T.el -> 'b M.T.el)
    val (<-$>) : 'a M.T.el -> (('a -> 'b) -> 'b M.T.el)
    val bang : 'a M.T.el -> unit M.T.el
  end = functor (M : Sig.FUNCTOR) -> struct
    let (<$->) = M.map
    let (<-$>) x = Ambient.flip (<$->) x
    let bang x = Ambient.bang <$-> x
  end

  module Profunctor : functor (M : Sig.PROFUNCTOR) -> sig
    val lmap : ('a -> 'b) -> (('b, 'c) M.T.el -> ('a, 'c) M.T.el)
    val rmap : ('c -> 'd) -> (('b, 'c) M.T.el -> ('b, 'd) M.T.el)
  end = functor (M : Sig.PROFUNCTOR) -> struct
    let lmap f = M.dimap f Ambient.id
    let rmap f = M.dimap Ambient.id f
  end

  module Semigroupoid : functor (M : Sig.SEMIGROUPOID) -> sig
    val (%>) : ('b, 'c) M.T.el -> ('a, 'b) M.T.el -> ('a, 'c) M.T.el
    val (%<) : ('a, 'b) M.T.el -> ('b, 'c) M.T.el -> ('a, 'c) M.T.el
  end = functor (M : Sig.SEMIGROUPOID) -> struct
    let (%>) = M.compose
    let (%<) f = Ambient.flip M.compose f
  end

  module Apply : functor (M : Sig.APPLY) -> sig
    val (<*>) : ('a -> 'b) M.T.el -> ('a M.T.el -> 'b M.T.el)
  end = functor (M : Sig.APPLY) -> struct
    let (<*>) = M.apply
  end

  module Bind : functor (M : Sig.BIND) -> sig
    val (>>=) : 'a M.T.el -> ('a -> 'b M.T.el) -> 'b M.T.el
  end = functor (M : Sig.BIND) -> struct
    let (>>=) = M.bind
  end

  module Monad : functor (M : Sig.MONAD) -> sig
    val ap : ('a -> 'b) M.T.el -> ('a M.T.el -> 'b M.T.el)
  end = functor (M : Sig.MONAD) -> struct module E = Bind(M);; open M;; open E;;
    let ap mf mx = mf >>= fun f -> mx >>= fun x -> pure (f x)
  end
end

(* Individual structure instances are grouped by name and related properties.
   Each instance, such as Semigroup.Unit, is a combination of the core instance
   definition packed alongside co-instantiated structure extensions. *)

module Exists = functor (E : Ty.Sig.Unary.Invariant.CODE) -> struct
  module T = E
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
      with module T = Ty.Con.Unit =
    struct
      module T = Ty.Con.Unit
      let op _ _ = ()
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module String = struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.String =
    struct
      module T = Ty.Con.String
      let op x y = String.concat "" [x; y]
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Additive = struct
    module Int = struct
      module Def : Sig.SEMIGROUP
        with module T = Ty.Con.Int =
      struct
        module T = Ty.Con.Int
        let op = (+)
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def : Sig.SEMIGROUP
        with module T = Ty.Con.Float =
      struct
        module T = Ty.Con.Float
        let op = (+.)
      end
      include Def
      include Ext.Semigroup(Def)
    end
  end

  module Multiplicative = struct
    module Int = struct
      module Def : Sig.SEMIGROUP
        with module T = Ty.Con.Int =
      struct
        module T = Ty.Con.Int
        let op = ( * )
      end
      include Def
      include Ext.Semigroup(Def)
    end

    module Float = struct
      module Def : Sig.SEMIGROUP
        with module T = Ty.Con.Float =
      struct
        module T = Ty.Con.Float
        let op = ( *. )
      end
      include Def
      include Ext.Semigroup(Def)
    end
  end

  module List = functor (T : Ty.Sig.Nullary.Invariant.ELEM) -> struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.List.Mono(T) =
    struct
      module T = Ty.Con.List.Mono(T)
      let op = List.append
    end
    include Def
  end
end

module Monoid = struct
  module Unit = struct
    module Def : Sig.MONOID
      with module T = Semigroup.Unit.Def.T =
    struct
      include Semigroup.Unit.Def
      let unit = ()
    end
    include Def
  end

  module String = struct
    module Def : Sig.MONOID
      with module T = Semigroup.String.Def.T =
    struct
      include Semigroup.String.Def
      let unit = ""
    end
    include Def
  end

  module Additive = struct
    module Int = struct
      module Def : Sig.MONOID
        with module T = Semigroup.Additive.Int.Def.T =
      struct
        include Semigroup.Additive.Int.Def
        let unit = 0
      end
      include Def
    end

    module Float = struct
      module Def : Sig.MONOID
        with module T = Semigroup.Additive.Float.Def.T =
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
        with module T = Semigroup.Multiplicative.Int.Def.T =
      struct
        include Semigroup.Multiplicative.Int.Def
        let unit = 1
      end
      include Def
    end

    module Float = struct
      module Def : Sig.MONOID
        with module T = Semigroup.Multiplicative.Float.Def.T =
      struct
        include Semigroup.Multiplicative.Float.Def
        let unit = 1.0
      end
      include Def
    end
  end

  module List = functor (T : Ty.Sig.Nullary.Invariant.ELEM) -> struct
    module S = Semigroup.List(T)
    module Def : Sig.MONOID
      with module T = S.Def.T =
    struct
      include S.Def
      let unit = []
    end
    include Def
  end
end

module Semiring = struct
  module Unit = struct
    module Def : Sig.SEMIRING
      with module T = Ty.Con.Unit =
    struct
      module T = Ty.Con.Unit
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
      with module T = Ty.Con.Int =
    struct
      module Add = Monoid.Additive.Int.Def
      module Mul = Monoid.Multiplicative.Int.Def
      module T = Ty.Con.Int
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
      with module T = Ty.Con.Float =
    struct
      module Add = Monoid.Additive.Float.Def
      module Mul = Monoid.Multiplicative.Float.Def
      module T = Ty.Con.Float
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
      with module T = Semiring.Unit.Def.T =
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
      with module T = Semiring.Int.Def.T =
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
      with module T = Semiring.Float.Def.T =
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
      with module T = Semiring.Unit.Def.T =
    struct
      include Semiring.Unit.Def
      let sub _ _ = ()
    end
    include Def
    include Ext.Ring(Def)
  end

  module Int = struct
    module Def : Sig.RING
      with module T = Semiring.Int.Def.T =
    struct
      include Semiring.Int.Def
      let sub = (-)
    end
    include Def
    include Ext.Ring(Def)
  end

  module Float = struct
    module Def : Sig.RING
      with module T = Semiring.Float.Def.T =
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
      with module T = Ring.Unit.Def.T =
    struct
      include Ring.Unit.Def
      include (ModuloSemiring.Unit.Def : Sig.MODULOSEMIRING
        with module T := T)
    end
    include Def
  end

  module Float = struct
    module Def : Sig.DIVISIONRING
      with module T = Ring.Float.Def.T =
    struct
      include Ring.Float.Def
      include (ModuloSemiring.Float.Def : Sig.MODULOSEMIRING
        with module T := T)
    end
    include Def
  end
end

module Functor = struct
  module List = struct
    module Def : Sig.FUNCTOR
      with module T = Ty.Con.List.Poly =
    struct
      module T = Ty.Con.List.Poly
      let map = List.map
    end
    include Def
    include Ext.Functor(Def)
  end
end

module Bifunctor = struct
  module Tuple = struct
    open Ambient
    module Def : Sig.BIFUNCTOR
      with module T = Ty.Con.Tuple.Poly =
    struct
      module T = Ty.Con.Tuple.Poly
      let bimap f g = let open Product in
        let (%>) = Ambient.compose in pair (f %> fst) (g %> snd)
    end
    include Def
  end

  module Variant = struct
    open Ambient
    module Def : Sig.BIFUNCTOR
      with module T = Ty.Con.Variant.Poly =
    struct
      module T = Ty.Con.Variant.Poly
      let bimap f g = let open Coproduct in
        let (%>) = Ambient.compose in case (inl %> f) (inr %> g)
    end
    include Def
  end
end

module Profunctor = struct
  module Fun = struct
    module Def : Sig.PROFUNCTOR
      with module T = Ty.Con.Fun.Poly =
    struct
      module T = Ty.Con.Fun.Poly
      let dimap f g h = let (%>) = Ambient.compose in g %> h %> f
    end
    include Def
    include Ext.Profunctor(Def)
  end
end

module Semigroupoid = struct
  module Fun = struct
    module Def : Sig.SEMIGROUPOID
      with module T = Profunctor.Fun.Def.T =
    struct
      include Profunctor.Fun.Def
      let compose = Ambient.compose
    end
    include Def
    include Ext.Semigroupoid(Def)
  end
end

module Category = struct
  module Fn = struct
    module Def : Sig.CATEGORY
      with module T = Semigroupoid.Fun.Def.T =
    struct
      include Semigroupoid.Fun.Def
      let id = Ambient.id
    end
    include Def
  end
end

module Product = struct
  module Tuple = struct
    open Ambient
    module Def : Sig.PRODUCT
      with module T = Ty.Con.Tuple.Poly =
    struct
      include Bifunctor.Tuple.Def
      include Ambient.Product
    end
    include Def
  end
end

module Coproduct = struct
  module Variant = struct
    open Ambient
    module Def : Sig.COPRODUCT
      with module T = Ty.Con.Variant.Poly =
    struct
      include Bifunctor.Variant.Def
      include Ambient.Coproduct
    end
    include Def
  end
end

module Foldable = struct
  module List = struct
    module Def : Sig.FOLDABLE
      with module T = Ty.Con.List.Poly =
    struct
      module T = Ty.Con.List.Poly
      let foldr f i xs = List.fold_right f xs i
      let foldl = List.fold_left
      let fold_map (type m) (module M : Sig.MONOID with type T.el = m) act =
        let rec go acc rest = match rest with
          | [] -> acc
          | (x::xs) -> go (M.op (act x) acc) xs in
        go M.unit
    end
    include Def
  end
end

module Apply = struct
  module List = struct
    module Def : Sig.APPLY
      with module T = Functor.List.Def.T =
    struct
      include Functor.List.Def
      let rec apply : type b. ('a -> b) list -> ('a list -> b list) = fun fs xs ->
        let module S = Semigroup.List(struct type el = b end) in
        match fs with
        | [] -> []
        | (f::fs) -> S.op (map f xs) (apply fs xs)
    end
    include Def
    include Ext.Apply(Def)
  end
end

module Applicative = struct
  module List = struct
    module Def : Sig.APPLICATIVE
      with module T = Functor.List.Def.T =
    struct
      include Apply.List.Def
      let pure x = [x]
    end
    include Def
  end
end

module Traversable = struct
  module List = struct
    module Def : Sig.TRAVERSABLE
      with module T = Functor.List.Def.T =
    struct
      open Semigroupoid.Fun
      include Functor.List.Def
      include (Foldable.List.Def : module type of Foldable.List.Def
        with module T := T)
      let traverse (type m) (module A : Sig.APPLICATIVE with type T.tc = m) f =
        let module EFun = Ext.Functor(A) in let open EFun in
        let module EApp = Ext.Apply  (A) in let open EApp in
        let rec go xs = match xs with
          | [] -> A.pure []
          | (x::xs) -> (fun h t -> h :: t) <$-> (A.T.elem %> f @@ x) <*> go xs in
        A.T.code %> go
      let sequence (type m) (module A : Sig.APPLICATIVE with type T.tc = m) =
        let module EFun = Ext.Functor(A) in let open EFun in
        let module EApp = Ext.Apply  (A) in let open EApp in
        let rec go xs = match xs with
          | [] -> A.pure []
          | (x::xs) -> (fun h t -> h :: t) <$-> (A.T.elem x) <*> go xs in
        A.T.code %> go
    end
    include Def
  end
end

(** Examples **)

(* Existentials for list functor *)
let ex0 () : int = let module E = Exists(Functor.List.T) in
  let pkg = E.into [0; 1; 2; 3; 4] in (* pack *)
  E.from pkg { E.ap = List.length }   (* elim *)

(* Bifunctor for tuple *)
let ex1 () : int * string =
  Bifunctor.Tuple.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Semigroupoid for (->) *)
let ex2 () : int = let open Semigroupoid.Fun in
  (fun x -> x + 1) %> (fun x -> x * 2) @@ 10

(* Monoid for list *)
let ex3 () : int list =
  let module M = Monoid.List(struct type el = int end) in
  M.op [0;1;2;3] [4;5;6;7]

(* Foldable for list *)
let ex4 () : int =
  let module F = Foldable.List in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let input = [1; 2; 3; 4; 5] in
  let lhs = F.fold_map (module Add) Ambient.id input in
  let rhs = F.fold_map (module Mul) Ambient.id input in
    Add.op lhs rhs

(* Applicative for list *)
let ex5 () : int list =
  let module A = Applicative.List in
  A.apply [(fun x -> x * 2); (fun x -> x * 4); (fun x -> x * 8)] [1; 2; 3]

(* Traversable for list *)
let ex6 () : int list list =
  let open Semigroupoid.Fun in
  let module A = Applicative.List in
  let module T = Traversable.List in
  (* not very interesting but it works … *)
  let res = T.traverse (module A) (A.T.code %> A.pure) [0; 1; 2; 3; 4] in
  A.T.elem res (* = [[0; 1; 2; 3; 4]] *)
