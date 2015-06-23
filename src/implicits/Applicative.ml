open Prelude.Sig

let pure (implicit M : APPLICATIVE) = M.pure

implicit module Option = Prelude.Applicative.Option
implicit module List = Prelude.Applicative.List
