open Sig
open Ty

module Tuple = struct
  module Def = struct
    module T = Con.Tuple.Poly
    let bimap f g = let open Amb.Product in
      let (%>) = Amb.compose in pair (f %> fst) (g %> snd)
  end
  include Def
end

module Variant = struct
  module Def = struct
    module T = Con.Variant.Poly
    let bimap f g = let open Amb.Coproduct in
      let (%>) = Amb.compose in case (inl %> f) (inr %> g)
  end
  include Def
end
