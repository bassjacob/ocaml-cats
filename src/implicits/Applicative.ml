open Cats
open Cats.Sig

let pure (implicit M : APPLICATIVE) = M.pure

implicit module Option = Mod.Applicative.Option
implicit module List = Mod.Applicative.List
