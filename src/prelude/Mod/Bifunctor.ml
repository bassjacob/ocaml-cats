open Sig
open TyCon

module Tuple = struct
  module Def = struct
    module T = TC.Tuple
    let bimap f g = let open Amb.Product in
      let (%>) = Amb.compose in pair (f %> fst) (g %> snd)
  end
  include Def
end

module Variant = struct
  module Def = struct
    module T = TC.Variant
    let bimap f g = let open Amb.Coproduct in
      let (%>) = Amb.compose in case (inl %> f) (inr %> g)
  end
  include Def
end
