open Prelude.Sig
open Prelude.Ty

val apply : (implicit M : APPLY)
  -> ('a -> 'b) M.T.el
  -> ('a M.T.el -> 'b M.T.el)

implicit module List : APPLY with module T = Con.List.Poly
