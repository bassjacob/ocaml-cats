open Prelude
open Prelude.Sig

let map (implicit M : FUNCTOR) = M.map

implicit module Option = Mod.Functor.Option
implicit module List = Mod.Functor.List
