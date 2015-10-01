open Sig
open TyCon

module Unit = struct
  module Def = Def.Ring.Unit
  module Ext = struct
    include Semiring.Unit.Ext
    include Ext.Ring.Make(Def)
  end
  include Def
  include Ext
end

module Int = struct
  module Def = Def.Ring.Int
  module Ext = struct
    include Semiring.Int.Ext
    include Ext.Ring.Make(Def)
  end
  include Def
  include Ext
end

module Float = struct
  module Def = Def.Ring.Float
  module Ext = struct
    include Semiring.Float.Ext
    include Ext.Ring.Make(Def)
  end
  include Def
  include Ext
end
