open Sig;

open TyCon;

let module Cofree (F: FUNCTOR): {
  include module type Functor.Cofree F;
  include EXTEND with module T := T;
};
