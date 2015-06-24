open Semigroupoid.Fun
open Sig

module Make : functor (G : FUNCTOR) (H : FUNCTOR) -> RAN
