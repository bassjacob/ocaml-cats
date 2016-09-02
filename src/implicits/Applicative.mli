open Cats
open Cats.Sig

val pure : (implicit M : APPLICATIVE) -> 'a -> 'a M.T.el

implicit module Option : module type Mod.Applicative.Option
implicit module List : module type Mod.Applicative.List
