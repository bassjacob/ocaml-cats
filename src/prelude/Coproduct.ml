module Variant = struct
  open Ambient
  module Def : Sig.COPRODUCT
    with module T = Ty.Con.Variant.Poly =
  struct
    include Bifunctor.Variant.Def
    include Ambient.Coproduct
  end
  include Def
end
