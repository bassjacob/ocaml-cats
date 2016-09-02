open Sig;
open TyCon;

let module Make (M: EXTEND) => {
  open M;
  let (=>>) = extend;
  let (=>=) g f x => g (extend x f);
};
