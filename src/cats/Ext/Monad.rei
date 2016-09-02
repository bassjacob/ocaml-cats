open Sig;
open TyCon;

let module Make (M: MONAD): {
  open M;
  let ap: T.el ('a => 'b) => (T.el 'a => T.el 'b);
  let join: T.el (T.el 'a) => T.el 'a;
};
