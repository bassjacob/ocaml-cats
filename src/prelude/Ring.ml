open Sig

module Unit = struct
  module Def : RING
    with module T = Semiring.Unit.Def.T =
  struct
    include Semiring.Unit.Def
    let sub _ _ = ()
  end
  include Def
  include Ext.Ring(Def)
end

module Int = struct
  module Def : RING
    with module T = Semiring.Int.Def.T =
  struct
    include Semiring.Int.Def
    let sub = (-)
  end
  include Def
  include Ext.Ring(Def)
end

module Float = struct
  module Def : RING
    with module T = Semiring.Float.Def.T =
  struct
    include Semiring.Float.Def
    let sub = (-.)
  end
  include Def
  include Ext.Ring(Def)
end
