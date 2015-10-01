open Sig
open TyCon

module Unit : sig
  module Def = Def.DivisionRing.Unit
  include module type of Def
end

module Float : sig
  module Def = Def.DivisionRing.Float
  include module type of Def
end
