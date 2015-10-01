open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = Def.Bifoldable.Tuple
  include Def
end

module Variant = struct
  open Amb.Coproduct
  module Def = Def.Bifoldable.Variant
  include Def
end
