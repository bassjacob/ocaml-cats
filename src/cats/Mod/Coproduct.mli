open Sig
open TyCon

module Variant : sig
  module Def : COPRODUCT with module T = TC.Variant
  include (module type of Def)
end
