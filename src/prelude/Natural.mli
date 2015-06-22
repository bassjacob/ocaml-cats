open Sig

module Make
  : functor (F : FUNCTOR) (G : FUNCTOR) -> NATURAL
      with module F := F
       and module G := G
