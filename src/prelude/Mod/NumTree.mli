open Sig
open Ty.Sig

module Make : functor (F : Unary.Covariant.CO) -> NUMTREE
  with module F = F
