open Sig;
open TyCon;

let module Tuple: {
  include PRODUCT with module T = TC.Tuple;
};
