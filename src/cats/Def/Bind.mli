open Sig

module Identity : sig
  include BIND with module T = Functor.Identity.T
end
