open Sig;
open TyCon;

let module Variant = {
  include Bifunctor.Variant;
  include Amb.Coproduct;
};
