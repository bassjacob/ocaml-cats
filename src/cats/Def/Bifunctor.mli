open Sig
open TyCon

module Tuple : sig
  include BIFUNCTOR with module T = TC.Tuple
end

module Variant : sig
  include BIFUNCTOR with module T = TC.Variant
end
