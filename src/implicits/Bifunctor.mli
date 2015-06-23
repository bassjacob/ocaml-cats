open Prelude.Sig
open Prelude.Ty

val bimap : (implicit M : BIFUNCTOR)
  -> ('a -> 'b)
  -> ('c -> 'd)
  -> (('a, 'c) M.T.el -> ('b, 'd) M.T.el)

implicit module Tuple : BIFUNCTOR with module T = Con.Tuple.Poly

implicit module Variant : BIFUNCTOR with module T = Con.Variant.Poly
