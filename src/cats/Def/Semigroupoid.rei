open Sig;
open TyCon;

let module Fun: {
  include SEMIGROUPOID with module T = Profunctor.Fun.T;
};
