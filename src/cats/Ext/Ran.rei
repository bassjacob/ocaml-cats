open Sig;
open TyCon;

let module Make (Ran: RAN): {
  include FUNCTOR with module T := Ran.R;
};
