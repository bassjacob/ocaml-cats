open Sig;
open TyCon;

let module Make (E: TC1): {
  include EXISTENTIAL with module T := E;
};
