open Sig
open Ty

module Variant = struct
  open Ambient
  module Def = struct
    include Bifunctor.Variant.Def
    include Ambient.Coproduct
  end
  include Def
end
