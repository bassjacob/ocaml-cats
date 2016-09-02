open Sig;
open TyCon;

let module Make (M: RING) => {
  open M;
  let (-@) = sub;
  let negate x => zero -@ x;
};
