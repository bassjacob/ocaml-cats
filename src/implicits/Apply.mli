open Prelude.Sig
open Prelude

val apply : (implicit M : APPLY)
  -> ('a -> 'b) M.T.el
  -> ('a M.T.el -> 'b M.T.el)

implicit module Option : module type of Prelude.Apply.Option
implicit module List : module type of Prelude.Apply.List
