open Sig;
open TyCon;

let module Make (Ran: RAN) => {
  open Ran;
  let map f {ran} => {
    ran: fun k => ran @@ Amb.compose k f
  };
};
