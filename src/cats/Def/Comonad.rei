open Sig;
open TyCon;

let module Cofree (F: FUNCTOR): {
  include module type Extend.Cofree F;
  include COMONAD with module T := T;
};
