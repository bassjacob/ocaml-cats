open Prelude.Sig
open Prelude

val pure : (implicit M : APPLICATIVE) -> 'a -> 'a M.T.el

implicit module Option : module type of Prelude.Applicative.Option
implicit module List : module type of Prelude.Applicative.List
