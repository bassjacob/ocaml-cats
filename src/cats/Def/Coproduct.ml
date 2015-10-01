open Sig
open TyCon

module Variant = struct
  include Bifunctor.Variant
  include Amb.Coproduct
end
