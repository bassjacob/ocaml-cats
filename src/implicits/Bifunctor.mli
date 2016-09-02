open Cats
open Cats.Sig
open Cats.TyCon

val bimap : (implicit M : BIFUNCTOR)
  -> ('a -> 'b)
  -> ('c -> 'd)
  -> (('a, 'c) M.T.el -> ('b, 'd) M.T.el)

implicit module Tuple : module type Mod.Bifunctor.Tuple
implicit module Variant : module type Mod.Bifunctor.Variant
