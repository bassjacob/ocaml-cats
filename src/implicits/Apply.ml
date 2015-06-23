open Prelude.Sig

let apply (implicit M : APPLY) = M.apply

implicit module Option = Prelude.Apply.Option
implicit module List = Prelude.Apply.List
