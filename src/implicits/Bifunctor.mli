open Prelude.Sig
open Prelude.Ty

val bimap : (implicit M : BIFUNCTOR)
  -> ('a -> 'b)
  -> ('c -> 'd)
  -> (('a, 'c) M.T.el -> ('b, 'd) M.T.el)

implicit module Tuple : module type of Prelude.Bifunctor.Tuple
implicit module Variant : module type of Prelude.Bifunctor.Variant
