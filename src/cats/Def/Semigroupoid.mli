open Sig
open TyCon

module Fun : sig
  include SEMIGROUPOID with module T = Profunctor.Fun.T
end
