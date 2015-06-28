open Sig
open Ty
open Ty.Sig

module Tree : NUMTREE with module F = Con.Identity.Poly
module Con : Nullary.CO with type el = (bool, bool) Tree.t
module Def : NATURAL with module T = Con
include (module type of Def)
