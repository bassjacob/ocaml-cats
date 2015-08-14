open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    include Bifunctor.Tuple.Def
    let biapply f =
      let (%>) = Amb.compose in
      into (fst f %> fst) (snd f %> snd)
  end
  include Def
end
