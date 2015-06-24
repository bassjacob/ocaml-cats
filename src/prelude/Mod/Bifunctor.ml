open Ambient
open Sig
open Ty

module Tuple = struct
  module Def = struct
    module T = Con.Tuple.Poly
    let bimap f g = let open Ambient.Product in
      let (%>) = compose in pair (f %> fst) (g %> snd)
  end
  include Def
end

module Variant = struct
  module Def = struct
    module T = Con.Variant.Poly
    let bimap f g = let open Ambient.Coproduct in
      let (%>) = compose in case (inl %> f) (inr %> g)
  end
  include Def
end
