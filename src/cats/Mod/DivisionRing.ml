open Sig
open TyCon

module Unit = struct
  module Def = Def.DivisionRing.Unit
  include Def
end

module Float = struct
  module Def = Def.DivisionRing.Float
  include Def
end
