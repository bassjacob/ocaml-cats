open Sig
open TyCon

module Tuple = struct
  module Def = Def.Product.Tuple
  include Def
end
