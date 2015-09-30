open Cats
open Cats.Sig

val pure : (implicit M : APPLICATIVE) -> 'a -> 'a M.T.el

implicit module Option : module type of Mod.Applicative.Option
implicit module List : module type of Mod.Applicative.List
