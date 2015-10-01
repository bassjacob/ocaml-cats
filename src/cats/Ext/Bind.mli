open Sig
open TyCon

module Make : functor (M : BIND) -> sig open M
  val (>>=) : 'a T.el -> ('a -> 'b T.el) -> 'b T.el
  val (>=>) : ('b -> 'c T.el) -> ('a -> 'b T.el) -> ('a -> 'c T.el)
end
