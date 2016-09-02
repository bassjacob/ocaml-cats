open Sig;
open TyCon;

let module Tuple: {
  include BIAPPLICATIVE with module T = Bifunctor.Tuple.T;
};
