open Sig
open TyCon

module Free (F : FUNCTOR) : sig
  include MONAD with module T = Functor.Free(F).T
end

module Identity : sig
  include MONAD with module T = Functor.Identity.T
end
