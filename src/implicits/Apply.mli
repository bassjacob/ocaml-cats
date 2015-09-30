open Cats
open Cats.Sig

val apply : (implicit M : APPLY)
  -> ('a -> 'b) M.T.el
  -> ('a M.T.el -> 'b M.T.el)

implicit module Option : module type of Mod.Apply.Option
implicit module List : module type of Mod.Apply.List
