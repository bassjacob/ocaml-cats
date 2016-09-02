open Sig;
open TyCon;

let module Make (Lan: LAN): {
  include FUNCTOR with module T := Lan.L;
};
