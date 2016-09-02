open Sig;
open TyCon;

let module Make (E: TC1): {
  include UNIVERSAL with module T := E;
};
