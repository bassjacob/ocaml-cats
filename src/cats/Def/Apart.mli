open Sig
open TyCon

module I = Initial
module L = Leibniz

type ('a, 'b) obs =
  | Refl : ('a, 'a) obs
  | Void : I.t -> ('a, 'b) obs

include APART
  with module I := I
   and module L := L

val into : ('a, 'b) L.t -> ('a, 'b) obs
val from : ('a, 'b) obs -> ('a, 'b) L.t
