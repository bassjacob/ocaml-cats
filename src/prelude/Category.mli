open Sig

module Fun : sig
  module Def : CATEGORY with module T = Semigroupoid.Fun.Def.T
  include (module type of Def)
end
