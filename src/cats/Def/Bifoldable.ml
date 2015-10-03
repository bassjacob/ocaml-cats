open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module T = TC.Tuple

  let bifold_map (type m) (m : m monoid) f g p =
    let module M = (val m) in
    M.op (f (fst p)) (g (snd p))
end

module Variant = struct
  open Amb.Coproduct
  module T = TC.Variant

  let bifold_map _ = from
end
