open Sig;
open TyCon;

let module Make (M: FUNCTOR): {
  open M;
  let (<$->): ('a => 'b) => T.el 'a => T.el 'b;
  let (<-$>): T.el 'a => ('a => 'b) => T.el 'b;
  let bang: T.el 'a => T.el unit;
};
