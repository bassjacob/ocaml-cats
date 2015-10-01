open Sig
open TyCon

module Tuple = struct
  module Def = Def.Bifunctor.Tuple
  include Def
end

module Variant = struct
  module Def = Def.Bifunctor.Variant
  include Def
end
