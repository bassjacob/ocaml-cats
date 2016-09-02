open Sig;
open TyCon;

let module Make (M: SEMIGROUP): {
  open M;
  let (@): T.el => T.el => T.el;
};
