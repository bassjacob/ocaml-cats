open Sig
open TyCon

module Make : functor (J : TC1) (G : TC1) -> LAN
