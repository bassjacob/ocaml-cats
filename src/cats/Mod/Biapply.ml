open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = Def.Biapply.Tuple
  include Def
end
