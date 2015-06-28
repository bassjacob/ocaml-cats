open Sig

module Make : functor (M : POSITIVE) -> sig open M
  exception InvalidPred
  exception InvalidSub
  exception InvalidLog
  val take2 : t -> M.code * M.code option
  val take_pair : t -> t -> M.code * M.code
  val succ : t -> t
  val pred : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val exp2 : t -> t
  val log2 : t -> t
  val pow : t -> t -> t
end
