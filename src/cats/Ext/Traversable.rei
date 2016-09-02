open Sig;

open TyCon;

let module Make (M: TRAVERSABLE): {
  open M;
  let sequence: applicative 'm => T.el (ap 'm 'a) => ap 'm (T.el 'a);
};
