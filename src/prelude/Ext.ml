(* The Ext module collects structure extensions as module functors, i.e.,
   derived operations and related functionality. *)

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
