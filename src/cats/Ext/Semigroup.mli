open Sig

module Make : functor (M : SEMIGROUP) -> sig open M
  val (@) : T.el -> T.el -> T.el
end
