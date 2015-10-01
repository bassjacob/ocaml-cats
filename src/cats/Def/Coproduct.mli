open Sig
open TyCon

module Variant : sig
  include COPRODUCT with module T = TC.Variant
end
