open Sig
open TyCon

type ('a, 'b) t = Refl : ('a, 'a) t

include LEIBNIZ with type ('a, 'b) t := ('a, 'b) t
