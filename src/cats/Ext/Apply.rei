open Sig;

open TyCon;

let module Make (M: APPLY): {
  open M;
  /* let (<*>): T.el ('a => 'b) => T.el 'a => T.el 'b; */
};
