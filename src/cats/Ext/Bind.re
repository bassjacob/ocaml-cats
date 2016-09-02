open Sig;
open TyCon;

let module Make (M: BIND) => {
  open M;
  let (>>=) = bind;
  let (>=>) g f x => bind (f x) g;
};
