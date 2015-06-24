open Sig

module Fun : sig
  module Def : SEMIGROUPOID with module T = Profunctor.Fun.Def.T
  include (module type of Def)
  include (module type of Ext.Semigroupoid.Make(Def))
end
