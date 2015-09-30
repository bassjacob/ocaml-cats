open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    module T = TC.Tuple
    let bimap f g =
      let (%>) = Amb.compose in
      into (f %> fst) (g %> snd)
  end
  include Def
end

module Variant = struct
  open Amb.Coproduct
  module Def = struct
    module T = TC.Variant
    let bimap f g =
      let (%>) = Amb.compose in
      from (inl %> f) (inr %> g)
  end
  include Def
end
