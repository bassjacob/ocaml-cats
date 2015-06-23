open Prelude.Sig
open Prelude.Ty

val map : (implicit M : FUNCTOR)
  -> ('a -> 'b)
  -> ('a M.T.el -> 'b M.T.el)

implicit module Option : module type of Prelude.Functor.Option
implicit module List : module type of Prelude.Functor.List
