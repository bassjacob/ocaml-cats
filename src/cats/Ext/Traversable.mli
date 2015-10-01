open Sig
open TyCon

module Make : functor (M : TRAVERSABLE) -> sig open M
  val sequence : 'm applicative
    -> ('a, 'm) ap T.el -> ('a T.el, 'm) ap
end
