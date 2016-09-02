open Sig;
open TyCon;

let module Diagonal (P: PROFUNCTOR) => TC1 {
  type t 'a = P.T.el 'a 'a;
};

let module Fun = {
  let module T = TC.Fun;
  let dimap f g h => {
    let (%>) = Amb.compose;
    g %> h %> f;
  };
};
