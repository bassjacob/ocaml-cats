open Sig;
open TyCon;

let module Make (M: SEMIGROUPOID) => {
  open M;
  let (%>) = compose;
  let (%<) f => Amb.flip compose f;
};
