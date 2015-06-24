open Prelude
open Prelude.Sig

let apply (implicit M : APPLY) = M.apply

implicit module Option = Mod.Apply.Option
implicit module List = Mod.Apply.List
