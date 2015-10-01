open Sig
open TyCon

module Variant = struct
  module Def = Def.Coproduct.Variant
  include Def
end
