open Sig

module Unit = struct
  module Def = struct
    include Ring.Unit.Def
    include (ModuloSemiring.Unit.Def : MODULOSEMIRING with module T := T)
  end
  include Def
end

module Float = struct
  module Def = struct
    include Ring.Float.Def
    include (ModuloSemiring.Float.Def : MODULOSEMIRING with module T := T)
  end
  include Def
end
