open Prelude.Sig

let apply (implicit M : APPLY) = M.apply

implicit module List = Prelude.Apply.List
