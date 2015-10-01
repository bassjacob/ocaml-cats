open Sig
open TyCon

module Unit : sig
  include DIVISIONRING with module T = Ring.Unit.T
end

module Float : sig
  include Sig.DIVISIONRING with module T = Ring.Float.T
end
