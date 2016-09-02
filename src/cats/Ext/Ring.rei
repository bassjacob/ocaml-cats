open Sig;
open TyCon;

let module Make (M: RING): {
  open M;
  let (-@): T.el => T.el => T.el;
  let negate: T.el => T.el;
};
