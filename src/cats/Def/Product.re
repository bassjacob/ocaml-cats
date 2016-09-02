open Sig;
open TyCon;

let module Tuple = {
  include Bifunctor.Tuple;
  include Amb.Product;
};
