open Prelude.Sig

let bimap (implicit M : BIFUNCTOR) = M.bimap

implicit module Tuple = Prelude.Bifunctor.Tuple
implicit module Variant = Prelude.Bifunctor.Variant
