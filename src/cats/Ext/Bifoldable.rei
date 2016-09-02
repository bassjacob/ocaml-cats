open Sig;

open TyCon;

let module Make (M: BIFOLDABLE): {
    open M;
    let bifoldr: ('a => 'c => 'c) => ('b => 'c => 'c) => 'c => T.el 'a 'b => 'c;
    let bifoldl: ('c => 'a => 'c) => ('c => 'b => 'c) => 'c => T.el 'a 'b => 'c;
    let biany: ('a => bool) => ('b => bool) => T.el 'a 'b => bool;
    let biall: ('a => bool) => ('b => bool) => T.el 'a 'b => bool;
  };
