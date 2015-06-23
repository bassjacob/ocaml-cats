open Prelude.Sig

let foldr (implicit M : FOLDABLE) = M.foldr
let foldl (implicit M : FOLDABLE) = M.foldl
let fold_map (implicit M : FOLDABLE) = M.fold_map

implicit module Option = Prelude.Foldable.Option
implicit module List = Prelude.Foldable.List
