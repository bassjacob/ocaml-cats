open Sig
open TyCon

module Unit = struct
  module Def = Def.ModuloSemiring.Unit
  module Ext = struct
    include Semiring.Unit.Ext
    include Ext.ModuloSemiring.Make(Def)
  end
  include Def
  include Ext
end

module Int = struct
  module Def = Def.ModuloSemiring.Int
  module Ext = struct
    include Semiring.Int.Ext
    include Ext.ModuloSemiring.Make(Def)
  end
  include Def
  include Ext
end

module Float = struct
  module Def = Def.ModuloSemiring.Float
  module Ext = struct
    include Semiring.Float.Ext
    include Ext.ModuloSemiring.Make(Def)
  end
  include Def
  include Ext
end
