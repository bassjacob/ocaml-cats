open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FFol: FOLDABLE with module T = FFun.T) => {
  include Cofree.Make FFun;
  let fold_map (type m) (m: Sig.monoid m) => {
    let module M = (val m);
    let functor' = FFol.fold_map m;
    let rec cofree act (Fork x xs) => M.op (act x) (functor' (cofree act) xs);
    cofree;
  };
};

let module List = {
  let module T = TC.List;
  let fold_map (type m) (m: monoid m) act => {
    let module M = (val m);
    let rec go acc rest =>
      switch rest {
      | [] => acc
      | [x, ...xs] => go (M.op (act x) acc) xs
      };
    go M.unit;
  };
};

let module Option = {
  let module T = TC.Option;
  let fold_map (type m) (m: monoid m) act => {
    let module M = (val m);
    fun
    | None => M.unit
    | Some x => M.op (act x) M.unit
  };
};
