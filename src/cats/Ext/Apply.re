open Sig;
open TyCon;

let module Make (M: APPLY) => {
  open M;
  /* let (<*>) = apply; */
};
