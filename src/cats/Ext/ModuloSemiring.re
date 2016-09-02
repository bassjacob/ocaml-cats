open Sig;
open TyCon;

let module Make (M: MODULOSEMIRING) => {
  open M;
  let (/@) = div;
  let (%@) = modulo;
};
