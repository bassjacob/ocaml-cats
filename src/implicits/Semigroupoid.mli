open Cats
open Cats.Sig

val compose : (implicit M : SEMIGROUPOID)
  -> ('b, 'c) M.T.el
  -> ('a, 'b) M.T.el
  -> ('a, 'c) M.T.el

implicit module Fun : module type of Mod.Semigroupoid.Fun

module Ext : sig
  val (%>) : (implicit M : SEMIGROUPOID)
    -> ('b, 'c) M.T.el
    -> ('a, 'b) M.T.el
    -> ('a, 'c) M.T.el
  val (%<) : (implicit M : SEMIGROUPOID)
    -> ('a, 'b) M.T.el
    -> ('b, 'c) M.T.el
    -> ('a, 'c) M.T.el
end
