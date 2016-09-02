open Sig;
open TyCon;

let module Variant: {
  include COPRODUCT with module T = TC.Variant;
};
