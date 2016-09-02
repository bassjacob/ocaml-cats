open Sig;
open TyCon;

let module Make (M: FOLDABLE): {
  open M;
  let foldr: ('a => 'b => 'b) => 'b => T.el 'a => 'b;
  let foldl: ('b => 'a => 'b) => 'b => T.el 'a => 'b;
  let any: ('a => bool) => T.el 'a => bool;
  let all: ('a => bool) => T.el 'a => bool;
  let elem: 'a => T.el 'a => bool;
};
