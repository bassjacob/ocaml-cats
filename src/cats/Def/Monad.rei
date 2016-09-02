open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  include MONAD with module T = Functor.Free(F).T;
};

let module Identity: {
  include MONAD with module T = Functor.Identity.T;
};
