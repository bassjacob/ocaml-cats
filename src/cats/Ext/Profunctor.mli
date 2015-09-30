open Sig

module Make : functor (M : PROFUNCTOR) -> sig open M
  val lmap : ('a -> 'b) -> (('b, 'c) T.el -> ('a, 'c) T.el)
  val rmap : ('c -> 'd) -> (('b, 'c) T.el -> ('b, 'd) T.el)
end
