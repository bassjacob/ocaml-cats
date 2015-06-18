let const : 'a 'b. 'a -> ('b -> 'a) =
  fun x _ -> x

let id : 'a. 'a -> 'a =
  fun x -> x

let cmp : 'a 'b 'c. ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c) =
  fun g f x -> g (f x)

let curry : 'a 'b 'c. ('a * 'b -> 'c) -> ('a -> ('b -> 'c)) =
  fun f x y -> f (x, y)

let uncurry : 'a 'b 'c. ('a -> ('b -> 'c)) -> ('a * 'b -> 'c) =
  fun f (x, y) -> f x y

let ($) : 'a 'b. ('a -> 'b) -> ('a -> 'b) =
  fun f x -> f x

let embed : 'a 'r. 'a -> (('a -> 'r) -> 'r) =
  fun x k -> k x

let flip : 'a 'b 'c. ('a -> 'b -> 'c) -> ('b -> 'a -> 'c) =
  fun f x y -> f y x

module type PROFUNCTOR = sig
  type (-'a, +'b) t
  val dimap : ('a -> 'b) -> ('c -> 'd) -> (('b, 'c) t -> ('a, 'd) t)
end

module Functor = struct
  module type SIG = sig
    type +'a t
    val map : ('a -> 'b) -> ('a t -> 'b t)
  end
  module Make : functor (Hom : PROFUNCTOR) -> sig
    type dom
    type +'a t = (dom, 'a) Hom.t
    include (SIG with type +'a t := 'a t)
  end = functor (Hom : PROFUNCTOR) -> struct
    type dom
    type +'a t = (dom, 'a) Hom.t
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
    type -'a t = ('a, cod) Hom.t
    include (SIG with type -'a t := 'a t)
  end = functor (Hom : PROFUNCTOR) -> struct
    type cod
    type -'a t = ('a, cod) Hom.t
    let map f = Hom.dimap f id
  end
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
  type (-'a, +'b) t = 'a -> 'b
  let dimap f g h = fun x -> g (h (f x))
end
module   FunctorArrow =   Functor.Make(ProfunctorArrow)
module OpFunctorArrow = OpFunctor.Make(ProfunctorArrow)
