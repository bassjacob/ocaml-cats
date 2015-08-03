open Sig

module Make : functor (Lan : LAN) -> sig
  include FUNCTOR with module T := Lan.L
end
