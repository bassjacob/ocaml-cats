module Tuple = struct
  open Ambient
  module Def : Sig.PRODUCT
    with module T = Ty.Con.Tuple.Poly =
  struct
    include Bifunctor.Tuple.Def
    include Ambient.Product
  end
  include Def
end
