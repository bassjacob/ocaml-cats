open Sig
open TyCon

module Variant : sig
  module Def = Def.Coproduct.Variant
  include (module type of Def)
end
