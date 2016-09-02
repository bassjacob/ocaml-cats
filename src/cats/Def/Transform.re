open Sig;
open TyCon;

let module Make (F: FUNCTOR) (G: FUNCTOR) => {
  let module F = F;
  let module G = G;
  type t = {ap: 'x .F.T.el 'x => G.T.el 'x};
};
