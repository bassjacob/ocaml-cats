open Sig

module Unit = struct
  module Def = struct
    include Semiring.Unit.Def
    let div _ _ = ()
    let modulo _ _ = ()
  end
  include Def
  include Ext.ModuloSemiring.Make(Def)
end

module Int = struct
  module Def = struct
    include Semiring.Int.Def
    let div = (/)
    let modulo = (mod)
  end
  include Def
  include Ext.ModuloSemiring.Make(Def)
end

module Float = struct
  module Def = struct
    include Semiring.Float.Def
    let div = (/.)
    let modulo = mod_float
  end
  include Def
  include Ext.ModuloSemiring.Make(Def)
end
