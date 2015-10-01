open Sig
open TyCon

module Fun : sig
  include CATEGORY with module T = Semigroupoid.Fun.T
end
