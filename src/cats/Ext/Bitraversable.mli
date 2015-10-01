open Sig
open TyCon

module Make : functor (M : BITRAVERSABLE) -> sig open M
  val bisequence : 'm applicative
    -> (('a, 'm) ap, ('b, 'm) ap) T.el -> (('a, 'b) T.el, 'm) ap
end
