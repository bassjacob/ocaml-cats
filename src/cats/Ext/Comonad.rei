open Sig;
open TyCon;

let module Make (M: COMONAD): {
  open M;
  let split: T.el 'a => T.el (T.el 'a);
};
