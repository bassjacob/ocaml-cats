open Sig;

open TyCon;

let module Make (M: SEMIRING) => {
  open M;
  let (+@) = add;
  let (*@) = mul;
};
