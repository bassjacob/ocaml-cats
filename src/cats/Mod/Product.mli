open Sig
open TyCon

module Tuple : sig
  module Def = Def.Product.Tuple
  include module type of Def
end
