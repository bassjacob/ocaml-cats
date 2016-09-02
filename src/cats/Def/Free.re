open Sig;
open TyCon;

let module Make (F: FUNCTOR) => {
  type t 'a =
    | Leaf 'a
    | Fork (F.T.el (t 'a));
  let module T = TC1 {
    type nonrec t 'a = t 'a;
  };
};
