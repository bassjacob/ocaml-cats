open Sig

module Unit : sig
  module Def : DIVISIONRING with module T = Ring.Unit.Def.T
  include (module type of Def)
end

module Float : sig
  module Def : Sig.DIVISIONRING with module T = Ring.Float.Def.T
  include (module type of Def)
end
