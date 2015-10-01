open Sig
open TyCon

module Identity : sig
  include MONAD with module T = Functor.Identity.T
end
