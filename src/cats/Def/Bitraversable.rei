open Sig;

let module Tuple: {
  include BITRAVERSABLE with module T = Bifunctor.Tuple.T;
};
