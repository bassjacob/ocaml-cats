open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FTra: TRAVERSABLE with module T = FFun.T) => {
  let module Data = Cofree.Make FFun;
  include Functor.Cofree FFun;
  include (Foldable.Cofree FFun FTra: module type Foldable.Cofree FFun FTra with module T := T);
  let fork x xs => Data.Fork x xs;
  let traverse (type m) (m: Sig.applicative m) act => {
    let module M = (val m);
    let functor' = FTra.traverse m;
    let rec cofree (Data.Fork x xs) =>
      M.T.co @@ M.apply (M.map fork (M.T.el (act x))) (M.T.el (functor' cofree xs));
    cofree
  };
};

let module List = {
  include Functor.List;
  include (Foldable.List: module type Foldable.List with module T := T);
  let traverse (type m) (m: applicative m) act => {
    let module M = (val m);
    let rec go xs =>
      switch xs {
      | [] => M.pure []
      | [x, ...xs] => M.apply (M.map Amb.cons (M.T.el (act x))) (go xs)
      };
    Amb.compose M.T.co go
  };
};
