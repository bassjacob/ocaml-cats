(* The Sig module collects structure signatures. *)

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
