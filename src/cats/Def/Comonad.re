open Sig;
open TyCon;

let module Cofree (F: FUNCTOR) => {
  let module Data = Cofree.Make F;
  include Extend.Cofree F;
  let extract (Data.Fork x _) => x;
};
