open Sig

module type Make = functor (L : LEIBNIZ) -> sig
  val cast : ('a, 'b) L.t -> ('a -> 'b)
end
