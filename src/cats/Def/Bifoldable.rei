open Sig;
open TyCon;

let module Tuple: {
  include BIFOLDABLE with module T = TC.Tuple;
};

let module Variant: {
  include BIFOLDABLE with module T = TC.Variant;
};
