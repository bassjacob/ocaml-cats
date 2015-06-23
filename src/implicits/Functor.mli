open Prelude.Sig
open Prelude.Ty

val map : (implicit M : FUNCTOR)
  -> ('a -> 'b)
  -> ('a M.T.el -> 'b M.T.el)

implicit module Option : FUNCTOR with module T = Con.Option.Poly
implicit module List : FUNCTOR with module T = Con.List.Poly
