open Sig

module Make : functor (M : RING) -> sig open M
  val (-@) : T.el -> T.el -> T.el
  val negate : T.el -> T.el
end
