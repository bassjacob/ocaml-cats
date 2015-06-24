open Sig

module Make : functor (M : SEMIGROUPOID) -> sig open M
  val (%>) : ('b, 'c) T.el -> ('a, 'b) T.el -> ('a, 'c) T.el
  val (%<) : ('a, 'b) T.el -> ('b, 'c) T.el -> ('a, 'c) T.el
end
