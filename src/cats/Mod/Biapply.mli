open Sig
open TyCon

module Tuple : sig
  module Def = Def.Biapply.Tuple
  include module type of Def
end
