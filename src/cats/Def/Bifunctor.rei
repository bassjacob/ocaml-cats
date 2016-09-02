open Sig;
open TyCon;

let module Tuple: {
  include BIFUNCTOR with module T = TC.Tuple;
};

let module Variant: {
  include BIFUNCTOR with module T = TC.Variant;
};
