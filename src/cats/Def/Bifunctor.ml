open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module T = TC.Tuple

  let bimap f g =
    let (%>) = Amb.compose in
    into (f %> fst) (g %> snd)
end

module Variant = struct
  open Amb.Coproduct
  module T = TC.Variant

  let bimap f g =
    let (%>) = Amb.compose in
    from (inl %> f) (inr %> g)
end
