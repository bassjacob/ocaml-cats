open Sig
open TyCon

module Make : functor (M : COMONAD) -> sig open M
  val split : 'a T.el -> 'a T.el T.el
end
