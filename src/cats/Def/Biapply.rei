open Sig;
open TyCon;

let module Tuple: {
  include BIAPPLY with module T = Bifunctor.Tuple.T;
};
