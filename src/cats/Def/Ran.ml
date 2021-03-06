open Sig
open TyCon

(* right adjoint to the pullback (along J) *)
module Make (J : TC1) (G : TC1) = struct
  module J = J
  module G = G

  (* J↑* F ≅ F ∘ J *)
  module AlongJ = Pullback.Make(J)

  (* J↑* ⊣ Ran J G *)
  type 'a ran = { ran : 'x. ('a -> 'x J.el) -> 'x G.el }

  module R = TC1(struct type 'a t = 'a ran end)

  type 'f lhs = { lhs : 'x. ('x, 'f) AlongJ.t -> 'x G.el }
  type 'f rhs = { rhs : 'x. ('x, 'f) ap -> 'x R.el }

  (* (J↑* F ~> G) → (F ~> Ran J G) *)
  let into (type f) (m : f functor') lhs =
    let module F = (val m) in
    { rhs = fun f -> { ran = fun k -> lhs.lhs @@ F.T.co @@ F.map k @@ F.T.el @@ f } }

  (* (J↑* F ~> G) ← (F ~> Ran J G) *)
  let from (type f) (m : f functor') rhs =
    let module F = (val m) in
    { lhs = fun p -> (rhs.rhs p).ran Amb.id }
end
