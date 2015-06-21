module Tuple = struct
  module Def : Sig.BIFUNCTOR
    with module T = Ty.Con.Tuple.Poly =
  struct
    module T = Ty.Con.Tuple.Poly
    let bimap f g = let open Ambient.Product in
      let (%>) = Ambient.compose in pair (f %> fst) (g %> snd)
  end
  include Def
end

module Variant = struct
  module Def : Sig.BIFUNCTOR
    with module T = Ty.Con.Variant.Poly =
  struct
    module T = Ty.Con.Variant.Poly
    let bimap f g = let open Ambient.Coproduct in
      let (%>) = Ambient.compose in case (inl %> f) (inr %> g)
  end
  include Def
end
