open Prelude.Sig

let bimap (implicit M : BIFUNCTOR) f g = M.bimap f g

implicit module Tuple = Prelude.Bifunctor.Tuple

implicit module Variant = Prelude.Bifunctor.Variant

