open Sig;
open TyCon;

let module Make (M: COMONAD) => {
  let module E = Extend.Make M;
  open M;
  open E;
  let split mx => mx =>> Amb.id;
};
