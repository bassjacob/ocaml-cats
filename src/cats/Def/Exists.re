open Sig;
open TyCon;

let module Make (E: TC1) => {
  let module T = E;
  type elim 'r = {ap: 'x .T.el 'x => 'r};
  type t =
    | Pack (T.el 'x) :t;
  let into x => Pack x;
  let from p k =>
    switch p {
    | Pack e => k.ap e
    };
};
