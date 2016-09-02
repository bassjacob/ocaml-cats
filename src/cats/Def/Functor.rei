open Sig;
open TyCon;

let module Cofree (F: FUNCTOR): {
  include FUNCTOR with module T = Cofree.Make(F).T;
};

let module Free (F: FUNCTOR): {
  include FUNCTOR with module T = Free.Make(F).T;
};

let module Identity: {
  include FUNCTOR with module T = TC.Identity;
};

let module Option: {
  include FUNCTOR with module T = TC.Option;
};

let module List: {
  include FUNCTOR with module T = TC.List;
};
