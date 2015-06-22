open Sig
open Ty

module Variant = struct
  open Ambient
  module Def : COPRODUCT
    with module T = Con.Variant.Poly =
  struct
    include Bifunctor.Variant.Def
    include Ambient.Coproduct
  end
  include Def
end
