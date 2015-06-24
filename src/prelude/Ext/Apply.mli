open Sig

module Make : functor (M : APPLY) -> sig open M
  val (<*>) : ('a -> 'b) T.el -> ('a T.el -> 'b T.el)
end
