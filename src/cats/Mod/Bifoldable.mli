open Sig
open TyCon

module Tuple : sig
  module Def = Def.Bifoldable.Tuple
  include module type of Def
end

module Variant : sig
  module Def = Def.Bifoldable.Variant
  include module type of Def
end
