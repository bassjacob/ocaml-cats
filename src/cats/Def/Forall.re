open Sig;
open TyCon;

let module Make (E: TC1) => {
  let module T = E;
  type poly = {ap: 'x .T.el 'x};
  type t = poly;
  external into : poly => t = "%identity";
  external from : t => poly = "%identity";
};
