open Sig;
open TyCon;

let module Make (M: EXTEND): {
  open M;
  let (=>>): T.el 'a => (T.el 'a => 'b) => T.el 'b;
  let (=>=): (T.el 'b => 'c) => (T.el 'a => 'b) => T.el 'a => 'c;
};
