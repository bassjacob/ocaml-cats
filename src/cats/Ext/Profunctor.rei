open Sig;

open TyCon;

let module Make (M: PROFUNCTOR): {
  open M;
  let lmap: ('a => 'b) => (T.el 'b 'c => T.el 'a 'c);
  let rmap: ('c => 'd) => (T.el 'b 'c => T.el 'b 'd);
};
