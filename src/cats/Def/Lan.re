open Sig;
open TyCon;

/* left adjoint to the pullback (along J) */
let module Make (J: TC1) (G: TC1) => {
  let module J = J;
  let module G = G;
  /* J↑* F ≅ F ∘ J */
  let module AlongJ = Pullback.Make J;
  /* Lan J G ⊣ J↑* */
  type lan 'a =
    | Lan (J.el 'x => 'a) (G.el 'x): lan 'a;
  let module L = TC1 {
    type t 'a = lan 'a;
  };
  type lhs 'f = { lhs: 'x. G.el 'x => AlongJ.t 'f 'x };
  type rhs 'f = { rhs: 'x. L.el 'x => ap 'f 'x };
  /* (G ~> J↑* F) → (Lan J G ~> F) */
  let into (type f) (m: functor' f) lhs => {
    let module F = (val m);
    { rhs: fun (Lan k g) => F.T.co @@ F.map k @@ F.T.el @@ lhs.lhs @@ g }
  };
  /* (G ~> J↑* F) ← (Lan J G ~> F) */
  let from (type f) (m: functor' f) rhs => {
    let module F = (val m);
    { lhs: fun g => rhs.rhs (Lan Amb.id g) }
  };
};
