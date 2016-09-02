open Sig;
open TyCon;

let module Make (M: SEMIGROUP) => {
  open M;
  let (@) = op;
};
