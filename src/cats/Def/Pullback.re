open Sig;
open TyCon;

/* pullback (along J) */
let module Make (J: TC1) => {
  let module J = J;
  /* J↑* f ≅ f ∘ J */
  type t 'f 'x = ap 'f (J.el 'x);
};
