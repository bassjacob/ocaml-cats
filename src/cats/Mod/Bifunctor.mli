open Sig
open TyCon

module Tuple : sig
  module Def = Def.Bifunctor.Tuple
  include module type of Def
end

module Variant : sig
  module Def = Def.Bifunctor.Variant
  include module type of Def
end
