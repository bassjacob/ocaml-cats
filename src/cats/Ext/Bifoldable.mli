open Sig
open TyCon

module Make : functor (M : BIFOLDABLE) -> sig open M
  val bifoldr
     : ('a -> 'c -> 'c)
    -> ('b -> 'c -> 'c)
    -> ('c -> ('a, 'b) T.el -> 'c)
  val bifoldl
     : ('c -> 'a -> 'c)
    -> ('c -> 'b -> 'c)
    -> ('c -> ('a, 'b) T.el -> 'c)
   val biany : ('a -> bool) -> ('b -> bool) -> (('a, 'b) T.el -> bool)
   val biall : ('a -> bool) -> ('b -> bool) -> (('a, 'b) T.el -> bool)
end
