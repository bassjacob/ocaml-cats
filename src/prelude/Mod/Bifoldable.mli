open Sig
open TyCon

module Tuple : sig
  module Def : BIFOLDABLE with module T = TC.Tuple
  include (module type of Def)
end

module Variant : sig
  module Def : BIFOLDABLE with module T = TC.Variant
  include (module type of Def)
end
