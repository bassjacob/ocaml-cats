open Sig
open TyCon

module Tuple : sig
  include BIFOLDABLE with module T = TC.Tuple
end

module Variant : sig
  include BIFOLDABLE with module T = TC.Variant
end
