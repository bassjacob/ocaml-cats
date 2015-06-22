open Sig

module Unit = struct
  module Def = struct
    include Semiring.Unit.Def
    let sub _ _ = ()
  end
  include Def
  include Ext.Ring(Def)
end

module Int = struct
  module Def = struct
    include Semiring.Int.Def
    let sub = (-)
  end
  include Def
  include Ext.Ring(Def)
end

module Float = struct
  module Def = struct
    include Semiring.Float.Def
    let sub = (-.)
  end
  include Def
  include Ext.Ring(Def)
end
