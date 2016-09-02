open Sig;

open TyCon;

let module Make (M: BITRAVERSABLE): {
  open M;
  let bisequence: applicative 'm => T.el (ap 'm 'a) (ap 'm 'b) => ap 'm (T.el 'a 'b);
};
