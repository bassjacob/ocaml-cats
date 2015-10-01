open Sig
open TyCon

module Unit = struct
  module Def = Def.Semiring.Unit
  module Ext = struct
    include Ext.Semiring.Make(Def)
  end
  include Def
  include Ext
end

module Int = struct
  module Def = Def.Semiring.Int
  module Ext = struct
    include Ext.Semiring.Make(Def)
  end
  include Def
  include Ext
end

module Float = struct
  module Def = Def.Semiring.Float
  module Ext = struct
    include Ext.Semiring.Make(Def)
  end
  include Def
  include Ext
end
