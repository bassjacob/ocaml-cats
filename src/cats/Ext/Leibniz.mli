open Sig
open TyCon

module Make : functor (L : LEIBNIZ) -> sig
  val cast : ('a, 'b) L.t -> ('a -> 'b)
end
