open Sig
open TyCon

module Make : functor (M : FOLDABLE) -> sig open M
  val foldr : ('a -> 'b -> 'b) -> ('b -> 'a T.el -> 'b)
  val foldl : ('b -> 'a -> 'b) -> ('b -> 'a T.el -> 'b)
end
