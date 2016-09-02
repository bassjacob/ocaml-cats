open Sig;

open TyCon;

let module Make (M: BIND): {
    open M;
    let (>>=): T.el 'a => ('a => T.el 'b) => T.el 'b;
    let (>=>): ('b => T.el 'c) => ('a => T.el 'b) => 'a => T.el 'c;
  };
