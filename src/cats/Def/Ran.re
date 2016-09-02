open Sig;
open TyCon;

/* right adjoint to the pullback (along J) */
let module Make (J: TC1) (G: TC1) => {
  let module J = J;
  let module G = G;
  /* J↑* F ≅ F ∘ J */
  let module AlongJ = Pullback.Make J;
  /* J↑* ⊣ Ran J G */
  type ran 'a = {ran: 'x. ('a => J.el 'x) => G.el 'x};
  let module R = TC1 {
    type t 'a = ran 'a;
  };
  type lhs 'f = {lhs: 'x. AlongJ.t 'f 'x => G.el 'x};
  type rhs 'f = {rhs: 'x. ap 'f 'x => R.el 'x};
  /* (J↑* F ~> G) → (F ~> Ran J G) */
  let into (type f) (m: functor' f) lhs => {
    let module F = (val m);
    { rhs: fun f => { ran: fun k => lhs.lhs @@ F.T.co @@ F.map k @@ F.T.el @@ f } }
  };
  /* (J↑* F ~> G) ← (F ~> Ran J G) */
  let from (type f) (m: functor' f) rhs => {
    let module F = (val m);
    { lhs: fun p => (rhs.rhs p).ran Amb.id }
  };
};
