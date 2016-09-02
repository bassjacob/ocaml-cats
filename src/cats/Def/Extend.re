open Sig;
open TyCon;

let module Cofree (F: FUNCTOR) => {
  let module Data = Cofree.Make F;
  include Functor.Cofree F;
  let rec extend t k =>
    switch t {
    | Data.Fork _ xs => Data.Fork (k t) (F.map (fun x => extend x k) xs)
    };
};
