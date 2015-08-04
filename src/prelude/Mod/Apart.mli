open Sig

module I = Initial
module L = Leibniz

type ('a, 'b) obs =
  | Refl : ('a, 'a) obs
  | Void : I.t -> ('a, 'b) obs

include APART
  with module I := I
   and module L := L
