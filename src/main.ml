module type FUNCTOR = sig
  type +'a t
  val map : ('a -> 'b) -> ('a t -> 'b t)
end

module type OPFUNCTOR = sig
  type -'a t
  val map : ('a -> 'b) -> ('b t -> 'a t)
end

module type PROFUNCTOR = sig
  type (-'a, +'b) t
  val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) t -> ('a, 'd) t)
end

module type SEMICATEGORY = sig
  type (-'a, +'b) hom
  include (PROFUNCTOR with type (-'a, +'b) t := ('a, 'b) hom)
  val cmp : ('b, 'c) hom -> ('a, 'b) hom -> ('a, 'c) hom
end

module type CATEGORY = sig
  type (-'a, +'b) hom
  include (PROFUNCTOR with type (-'a, +'b) t := ('a, 'b) hom)
  val idn : ('a, 'a) hom
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
  type +'a m
  include (APPLICATIVE with type 'a t := 'a m)
  include (BIND with type 'a t := 'a m)
end

module FunctorArrow : FUNCTOR = struct
  type dom
  type +'a t = dom -> 'a
  let map f g = fun x -> f (g x)
end

module OpFunctorArrow : OPFUNCTOR = struct
  type cod
  type -'a t = 'a -> cod
  let map f g = fun x -> g (f x)
end

module ProfunctorArrow : PROFUNCTOR = struct
  type (-'a, +'b) t = 'a -> 'b
  let dimap f g h = fun x -> g (h (f x))
end
