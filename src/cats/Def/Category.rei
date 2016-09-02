open Sig;
open TyCon;

let module Fun: {
  include CATEGORY with module T = Semigroupoid.Fun.T;
};
