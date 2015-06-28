open Sig
open Ty
open Ty.Sig

module Tree = NumTree.Make(Con.Identity.Poly)

module Con = Ty.Make.Nullary(struct
  type el = (bool, bool) Tree.t
end)

module PosDef = struct
  exception InvalidDiv
  exception InvalidHead
  type code = B | O | I
  module T = Con

  let head = function
    | Tree.L true   -> B
    | Tree.N (h, t) -> if h then I else O
    | _             -> raise InvalidHead

  let one = Tree.L true

  let mul2 x = Tree.N (false, x)

  let mul2s x = Tree.N (true, x)

  let div2 = function
    | Tree.N (false, x) -> x
    | _ -> raise InvalidDiv

  let div2p = function
    | Tree.N (true, x) -> x
    | _ -> raise InvalidDiv
end

module PosExt = Positive.Make(PosDef)

module Semiring = struct
  let zero = Tree.L false

  let add x y =
    if x = zero then y else
    if y = zero then x else
      PosExt.add x y

  let mul x y =
    if x = zero then zero else
    if y = zero then zero else
      PosExt.mul x y
end

module Def = struct
  include PosDef
  include Semiring
end

include Def
