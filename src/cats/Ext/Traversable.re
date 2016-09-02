open Sig;
open TyCon;

let module Make (M: TRAVERSABLE) => {
  open M;
  let sequence m => traverse m Amb.id;
};
