open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FFol: FOLDABLE with module T = FFun.T): {
  include FOLDABLE with module T = Cofree.Make(FFun).T;
};

let module List: {
  include FOLDABLE with module T = TC.List;
};

let module Option: {
  include FOLDABLE with module T = TC.Option;
};
