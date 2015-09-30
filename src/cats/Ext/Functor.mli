open Sig

module Make : functor (M : FUNCTOR) -> sig open M
  val (<$->) : ('a -> 'b) -> ('a T.el -> 'b T.el)
  val (<-$>) : 'a T.el -> (('a -> 'b) -> 'b T.el)
  val bang : 'a T.el -> unit T.el
end
