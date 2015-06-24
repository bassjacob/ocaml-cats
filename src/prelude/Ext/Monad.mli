open Sig

module Make : functor (M : MONAD) -> sig open M
  val ap : ('a -> 'b) T.el -> ('a T.el -> 'b T.el)
end
