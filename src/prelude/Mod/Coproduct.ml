open Sig
open TyCon

module Variant = struct
  module Def = struct
    include Bifunctor.Variant.Def
    include Amb.Coproduct
  end
  include Def
end
