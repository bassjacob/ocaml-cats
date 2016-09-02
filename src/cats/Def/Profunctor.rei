open Sig;
open TyCon;

let module Diagonal (P: PROFUNCTOR): TC1 with type el 'a = P.T.el 'a 'a;

let module Fun: {
  include PROFUNCTOR with module T = TC.Fun;
};
