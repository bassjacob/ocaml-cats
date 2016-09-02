open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  include BIND with module T = Functor.Free(F).T;
};

let module Identity: {
  include BIND with module T = Functor.Identity.T;
};
