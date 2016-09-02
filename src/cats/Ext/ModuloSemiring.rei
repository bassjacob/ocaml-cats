open Sig;
open TyCon;

let module Make (M: MODULOSEMIRING): {
  open M;
  let (/@): T.el => T.el => T.el;
  let (%@): T.el => T.el => T.el;
};
