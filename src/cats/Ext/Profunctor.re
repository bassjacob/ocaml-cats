open Sig;
open TyCon;

let module Make (M: PROFUNCTOR) => {
  open M;
  let lmap f => dimap f Amb.id;
  let rmap f => dimap Amb.id f;
};
