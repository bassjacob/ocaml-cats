open Sig
open TyCon

module Tuple : sig
  module Def = Def.Biapplicative.Tuple
  include module type of Def
end
