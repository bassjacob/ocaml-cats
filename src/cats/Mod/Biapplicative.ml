open Sig
open TyCon

module Tuple = struct
  module Def = Def.Biapplicative.Tuple
  include Def
end
