open Sig
open Ty.Sig

module Make : functor (T : Unary.Covariant.CO) -> NUMTREE
  with module T = T
