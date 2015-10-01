open Sig
open TyCon

module Make : functor (M : EXTEND) -> sig open M
  val (=>>) : 'a T.el -> ('a T.el -> 'b) -> 'b T.el
  val (=>=) : ('b T.el -> 'c) -> ('a T.el -> 'b) -> ('a T.el -> 'c)
end
