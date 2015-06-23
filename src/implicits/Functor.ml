open Prelude.Sig

let map (implicit M : FUNCTOR) = M.map

implicit module Option = Prelude.Functor.Option
implicit module List = Prelude.Functor.List
