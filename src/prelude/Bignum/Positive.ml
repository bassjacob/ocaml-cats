open Sig
open Ty
open Ty.Sig

module Tree = NumTree.Make(Con.Identity.Poly)

module Con = Ty.Make.Nullary(struct
  type el = (unit, bool) Tree.t
end)

module Def = struct
  exception InvalidDiv
  type code = B | O | I
  module T = Con

  let head = function
    | Tree.L _ -> B
    | Tree.N (h, _) -> if h then I else O

  let one = Tree.L ()

  let mul2 x = Tree.N (false, x)

  let mul2s x = Tree.N (true, x)

  let div2 = function
    | Tree.N (false, x) -> x
    | _ -> raise InvalidDiv

  let div2p = function
    | Tree.N (true, x) -> x
    | _ -> raise InvalidDiv
end

module Make (M : POSITIVE) = struct open M
  exception InvalidPred
  exception InvalidSub
  exception InvalidLog

  let take2 x =
    let lhs = M.head x in
    let rhs = match lhs with
      | B -> None
      | O -> Some (M.head (M.div2  x))
      | I -> Some (M.head (M.div2p x)) in
    (lhs, rhs)

  let take_pair x y = (M.head x, M.head y)

  let rec succ x = match M.head x with
    | B -> M.mul2                x
    | O -> M.mul2s      (M.div2  x)
    | I -> M.mul2 (succ (M.div2p x))

  let rec pred x = match take2 x with
    | (O, Some B) -> M.one
    | (O, _     ) -> M.mul2s (pred (M.div2  x))
    | (I, _     ) -> M.mul2        (M.div2p x)
    | _ -> raise InvalidPred

  let rec add x y = match take_pair x y with
    | (B, _) -> succ y
    | (_, B) -> succ x
    | (O, O) -> M.mul2       (add (M.div2  x) (M.div2  y))
    | (O, I) -> M.mul2s      (add (M.div2  x) (M.div2p y))
    | (I, O) -> M.mul2s      (add (M.div2p x) (M.div2  y))
    | (I, I) -> M.mul2 (succ (add (M.div2p x) (M.div2p y)))

  let rec sub x y =
    if x = succ y then
      M.one
    else
      match take_pair x y with
      | (_, B) -> pred x
      | (O, O) ->       M.mul2  (sub (M.div2  x) (M.div2  y))
      | (O, I) -> pred (M.mul2  (sub (M.div2  x) (M.div2p y)))
      | (I, O) ->       M.mul2s (sub (M.div2p x) (M.div2  y))
      | (I, I) ->       M.mul2  (sub (M.div2p x) (M.div2p y))
      | _ -> raise InvalidSub

  let mul xi yi =
    let rec go x y = match M.head x with
      | B -> y
      | O ->        M.mul2 (go (M.div2  x) y)
      | I -> add y (M.mul2 (go (M.div2p x) y)) in
    match take_pair xi yi with
    | (B, _) -> yi
    | (_, B) -> xi
    | _      -> go xi yi

  let rec exp2 x = match M.head x with
    | B -> succ one
    | _ -> M.mul2 (exp2 (pred x))

  let rec log2 x = match take2 x with
    | (O, Some B) -> M.one
    | (O, _)      ->       succ (log2 (M.div2  x))
    | (I, _)      -> succ (succ (log2 (M.div2p x)))
    | _           -> raise InvalidLog

  let rec pow xi yi =
    let go x y = match M.head y with
      | B -> x
      | O ->       (pow (mul x x) (M.div2  y))
      | I -> mul x (pow (mul x x) (M.div2p y)) in
    match take2 xi with
    | (O, Some B) -> exp2 yi
    | _           -> go xi yi
end

include Def
include Make(Def)
