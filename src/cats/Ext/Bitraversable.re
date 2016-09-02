open Sig;

open TyCon;

let module Make (M: BITRAVERSABLE) => {
  open M;
  let bisequence m => bitraverse m Amb.id Amb.id;
};
