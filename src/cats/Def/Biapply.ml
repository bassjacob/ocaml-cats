open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  include Bifunctor.Tuple
  let biapply f =
    let (%>) = Amb.compose in
    into (fst f %> fst) (snd f %> snd)
end
