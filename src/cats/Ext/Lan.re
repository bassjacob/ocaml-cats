open Sig;
open TyCon;

let module Make (Lan: LAN) => {
  open Lan;
  let map f (Lan k g) => Lan (Amb.compose f k) g;
};
