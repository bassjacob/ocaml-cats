open Ambient
open Sig

(* The Ext module collects structure extensions as module functors, i.e.,
   derived operations and related functionality. *)

module Semigroup : functor (M : SEMIGROUP) -> sig open M
  val (@) : T.el -> T.el -> T.el
end = functor (M : SEMIGROUP) -> struct open M
  let (@) = op
end

module Semiring : functor (M : SEMIRING) -> sig open M
  val ( +@ ) : T.el -> T.el -> T.el
  val ( *@ ) : T.el -> T.el -> T.el
end = functor (M : SEMIRING) -> struct open M
  let ( +@ ) = add
  let ( *@ ) = mul
end

module ModuloSemiring : functor (M : MODULOSEMIRING) -> sig open M
  val (/@) : T.el -> T.el -> T.el
  val (%@) : T.el -> T.el -> T.el
end = functor (M : MODULOSEMIRING) -> struct open M
  let (/@) = div
  let (%@) = modulo
end

module Ring : functor (M : RING) -> sig open M
  val (-@) : T.el -> T.el -> T.el
  val negate : T.el -> T.el
end = functor (M : RING) -> struct open M
  let (-@) = sub
  let negate x = zero -@ x
end

module Functor : functor (M : FUNCTOR) -> sig open M
  val (<$->) : ('a -> 'b) -> ('a T.el -> 'b T.el)
  val (<-$>) : 'a T.el -> (('a -> 'b) -> 'b T.el)
  val bang : 'a T.el -> unit T.el
end = functor (M : FUNCTOR) -> struct open M
  let (<$->) = map
  let (<-$>) x = flip (<$->) x
  let bang x = bang <$-> x
end

module Profunctor : functor (M : PROFUNCTOR) -> sig open M
  val lmap : ('a -> 'b) -> (('b, 'c) T.el -> ('a, 'c) T.el)
  val rmap : ('c -> 'd) -> (('b, 'c) T.el -> ('b, 'd) T.el)
end = functor (M : PROFUNCTOR) -> struct open M
  let lmap f = dimap f id
  let rmap f = dimap id f
end

module Semigroupoid : functor (M : SEMIGROUPOID) -> sig open M
  val (%>) : ('b, 'c) T.el -> ('a, 'b) T.el -> ('a, 'c) T.el
  val (%<) : ('a, 'b) T.el -> ('b, 'c) T.el -> ('a, 'c) T.el
end = functor (M : SEMIGROUPOID) -> struct open M
  let (%>) = compose
  let (%<) f = flip compose f
end

module Apply : functor (M : APPLY) -> sig open M
  val (<*>) : ('a -> 'b) T.el -> ('a T.el -> 'b T.el)
end = functor (M : APPLY) -> struct open M
  let (<*>) = apply
end

module Bind : functor (M : BIND) -> sig open M
  val (>>=) : 'a T.el -> ('a -> 'b T.el) -> 'b T.el
end = functor (M : BIND) -> struct open M
  let (>>=) = bind
end

module Monad : functor (M : MONAD) -> sig open M
  val ap : ('a -> 'b) T.el -> ('a T.el -> 'b T.el)
end = functor (M : MONAD) -> struct module E = Bind(M);; open M;; open E;;
  let ap mf mx = mf >>= fun f -> mx >>= fun x -> pure (f x)
end
