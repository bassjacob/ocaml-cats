open TyCon

(* The Sig module collects structure signatures. *)

module type INITIAL = sig
  type t
  val absurd : t -> 'a
end

module type TERMINAL = sig
  type t
  val bang : 'a -> t
end

module type LEIBNIZ = sig
  type ('a, 'b) t
  val refl : ('a, 'a) t
  val subst : (module TC1 with type co = 'f)
    -> ('a, 'b) t -> (('a, 'f) ap -> ('b, 'f) ap)
end

module type APART = sig
  module I : INITIAL
  module L : LEIBNIZ
  type ('a, 'b) t = ('a, 'b) L.t -> I.t
end

module type UNIVERSAL = sig
  module T : TC1
  type poly = { ap : 'x. 'x T.el }
  type t
  val into : poly -> t
  val from : t -> poly
end

module type EXISTENTIAL = sig
  module T : TC1
  type 'r elim = { ap : 'x. 'x T.el -> 'r }
  type t
  val into : 'a T.el -> t
  val from : t -> ('r elim -> 'r)
end

module type SEMIGROUP = sig
  module T : TC0
  val op : T.el -> T.el -> T.el
end

module type MONOID = sig
  include SEMIGROUP
  val unit : T.el
end

module type SEMIRING = sig
  module T : TC0
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
  module T : TC1
  val map : ('a -> 'b) -> ('a T.el -> 'b T.el)
end

module type BIFUNCTOR = sig
  module T : TC2
  val bimap : ('a -> 'b) -> ('c -> 'd) -> (('a, 'c) T.el -> ('b, 'd) T.el)
end

module type PRESHEAF = sig
  module T : TC1
  val premap : ('a -> 'b) -> ('b T.el -> 'a T.el)
end

module type PROFUNCTOR = sig
  module T : TC2
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

module type END = sig
  module Hom : PROFUNCTOR
  type poly = { ap : 'x. ('x, 'x) Hom.T.el }
  type t
  val into : poly -> t
  val from : t -> poly
end

module type COEND = sig
  module Hom : PROFUNCTOR
  type 'r elim = { ap : 'x. ('x, 'x) Hom.T.el -> 'r }
  type t
  val into : ('a, 'a) Hom.T.el -> t
  val from : t -> ('r elim -> 'r)
end

module type TRANSFORM = sig
  module F : FUNCTOR
  module G : FUNCTOR
  type t = { ap : 'x. 'x F.T.el -> 'x G.T.el }
end

(* pullback (along J) *)
module type PULLBACK = sig
  module J : TC1
  (* J↑* f ≅ f ∘ J *)
  type ('x, 'f) t = ('x J.el, 'f) ap
end

(* left adjoint to the pullback (along J) *)
module type LAN = sig
  module J : TC1
  module G : TC1
  (* J↑* F ≅ F ∘ J *)
  module AlongJ : PULLBACK with module J = J
  (* Lan J G ⊣ J↑* *)
  type 'a lan = Lan : ('x J.el -> 'a) * 'x G.el -> 'a lan
  module L : TC1 with type 'a el = 'a lan
  type 'f lhs = { lhs : 'x. 'x G.el -> ('x, 'f) AlongJ.t }
  type 'f rhs = { rhs : 'x. 'x L.el -> ('x, 'f) ap }
  (* (G ~> J↑* F) → (Lan J G ~> F) *)
  val into : (module FUNCTOR with type T.co = 'f) -> 'f lhs -> 'f rhs
  (* (G ~> J↑* F) ← (Lan J G ~> F) *)
  val from : (module FUNCTOR with type T.co = 'f) -> 'f rhs -> 'f lhs
end

(* right adjoint to the pullback (along J) *)
module type RAN = sig
  module J : TC1
  module G : TC1
  (* J↑* F ≅ F ∘ J *)
  module AlongJ : PULLBACK with module J = J
  (* J↑* ⊣ Ran J G *)
  type 'a ran = { ran : 'x. ('a -> 'x J.el) -> 'x G.el }
  module R : TC1 with type 'a el = 'a ran
  type 'f lhs = { lhs : 'x. ('x, 'f) AlongJ.t -> 'x G.el }
  type 'f rhs = { rhs : 'x. ('x, 'f) ap -> 'x R.el }
  (* (J↑* F ~> G) → (F ~> Ran J G) *)
  val into : (module FUNCTOR with type T.co = 'f) -> 'f lhs -> 'f rhs
  (* (J↑* F ~> G) ← (F ~> Ran J G) *)
  val from : (module FUNCTOR with type T.co = 'f) -> 'f rhs -> 'f lhs
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
  module T : TC1
  val foldr : ('a -> 'b -> 'b) -> ('b -> 'a T.el -> 'b)
  val foldl : ('b -> 'a -> 'b) -> ('b -> 'a T.el -> 'b)
  val fold_map : (module MONOID with type T.el = 'm)
    -> ('a -> 'm) -> ('a T.el -> 'm)
end

module type TRAVERSABLE = sig
  include FUNCTOR
  include FOLDABLE with module T := T
  val traverse : (module APPLICATIVE with type T.co = 'm)
    -> ('a -> ('b, 'm) ap) -> ('a T.el -> ('b T.el, 'm) ap)
  val sequence : (module APPLICATIVE with type T.co = 'm)
    -> ('a, 'm) ap T.el -> ('a T.el, 'm) ap
end
