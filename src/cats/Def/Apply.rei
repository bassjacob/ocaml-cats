open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  include APPLY with module T = Functor.Free(F).T;
};

let module Identity: {
  include APPLY with module T = Functor.Identity.T;
};

let module Option: {
  include APPLY with module T = Functor.Option.T;
};

let module List: {
  include APPLY with module T = Functor.List.T;
};
