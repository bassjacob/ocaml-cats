open Sig
open TyCon

module Make : functor (Lan : LAN) -> sig
  include FUNCTOR with module T := Lan.L
end
