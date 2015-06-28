open Sig

module Make : functor (M : POSITIVE) -> sig open M
  exception InvalidPred
  exception InvalidSub
  exception InvalidLog
  val take2 : T.el -> M.code * M.code option
  val take_pair : T.el -> T.el -> M.code * M.code
  val succ : T.el -> T.el
  val pred : T.el -> T.el
  val add : T.el -> T.el -> T.el
  val sub : T.el -> T.el -> T.el
  val mul : T.el -> T.el -> T.el
  val exp2 : T.el -> T.el
  val log2 : T.el -> T.el
  val pow : T.el -> T.el -> T.el
end
