open Prelude
open Prelude.Sig
open Prelude.Ty

val foldr : (implicit M : FOLDABLE)
  -> ('a -> 'b -> 'b)
  -> ('b -> 'a M.T.el -> 'b)

val foldl : (implicit M : FOLDABLE)
  -> ('b -> 'a -> 'b)
  -> ('b -> 'a M.T.el -> 'b)

val fold_map : (implicit M : FOLDABLE)
  -> (module MONOID with type T.el = 'm)
  -> ('a -> 'm)
  -> ('a M.T.el -> 'm)

implicit module Option : module type of Mod.Foldable.Option
implicit module List : module type of Mod.Foldable.List
