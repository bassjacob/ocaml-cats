open Sig

module Make
  : functor (F : FUNCTOR) (G : FUNCTOR) -> TRANSFORM
      with module F := F
       and module G := G
