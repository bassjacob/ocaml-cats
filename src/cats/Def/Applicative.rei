open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  include APPLICATIVE with module T = Functor.Free(F).T;
};

let module Identity: {
  include APPLICATIVE with module T = Functor.Identity.T;
};

let module Option: {
  include APPLICATIVE with module T = Functor.Option.T;
};

let module List: {
  include APPLICATIVE with module T = Functor.List.T;
};
