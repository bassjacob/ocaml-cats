open Sig

module Unit = struct
  module Def : MODULOSEMIRING
    with module T = Semiring.Unit.Def.T =
  struct
    include Semiring.Unit.Def
    let div _ _ = ()
    let modulo _ _ = ()
  end
  include Def
  include Ext.ModuloSemiring(Def)
end

module Int = struct
  module Def : MODULOSEMIRING
    with module T = Semiring.Int.Def.T =
  struct
    include Semiring.Int.Def
    let div = (/)
    let modulo = (mod)
  end
  include Def
  include Ext.ModuloSemiring(Def)
end

module Float = struct
  module Def : MODULOSEMIRING
    with module T = Semiring.Float.Def.T =
  struct
    include Semiring.Float.Def
    let div = (/.)
    let modulo = mod_float
  end
  include Def
  include Ext.ModuloSemiring(Def)
end
