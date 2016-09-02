open Sig;
open TyCon;

let module Make (F: FUNCTOR): {
  type t 'a =
    | Fork 'a (F.T.el (t 'a));
  let module T: TC1 with type el 'a = t 'a;
};
