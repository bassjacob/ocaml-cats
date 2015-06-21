module Unit = struct
  module Def : Sig.DIVISIONRING
    with module T = Ring.Unit.Def.T =
  struct
    include Ring.Unit.Def
    include (ModuloSemiring.Unit.Def : Sig.MODULOSEMIRING
             with module T := T)
  end
  include Def
end

module Float = struct
  module Def : Sig.DIVISIONRING
    with module T = Ring.Float.Def.T =
  struct
    include Ring.Float.Def
    include (ModuloSemiring.Float.Def : Sig.MODULOSEMIRING
             with module T := T)
  end
  include Def
end
