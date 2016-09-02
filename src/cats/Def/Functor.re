open Sig;
open TyCon;

let module Cofree (F: FUNCTOR) => {
  let module Data = Cofree.Make F;
  let module T = Data.T;
  let rec map f => fun
    | Data.Fork x xs => Data.Fork (f x) (F.map (map f) xs);
};

let module Free (F: FUNCTOR) => {
  let module Data = Free.Make F;
  let module T = Data.T;
  let rec map f => fun
    | Data.Leaf x => Data.Leaf (f x)
    | Data.Fork xs => Data.Fork (F.map (map f) xs);
};

let module Identity = {
  let module T = TC.Identity;
  let map f x => f x;
};

let module Option = {
  let module T = TC.Option;
  let map f => fun
    | None => None
    | Some x => Some (f x);
};

let module List = {
  let module T = TC.List;
  let map = List.map;
};
