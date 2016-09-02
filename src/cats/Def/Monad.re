open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  include Applicative.Free F;
  include (Bind.Free F: BIND with module T := T);
};

let module Identity = {
  include Applicative.Identity;
  include (Bind.Identity: BIND with module T := T);
};
