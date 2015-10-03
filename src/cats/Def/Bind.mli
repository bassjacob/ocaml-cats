open Sig

module Free (F : FUNCTOR) : sig
  include BIND with module T = Functor.Free(F).T
end

module Identity : sig
  include BIND with module T = Functor.Identity.T
end
