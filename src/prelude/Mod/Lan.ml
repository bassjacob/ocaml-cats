open Category.Fun
open Semigroupoid.Fun
open Sig
open TyCon

(* left adjoint to the pullback (along J) *)
module Make (J : TC1) (G : TC1) = struct
  module J = J
  module G = G
  (* J↑* F ≅ F ∘ J *)
  module AlongJ = Pullback.Make(J)
  (* Lan J G ⊣ J↑* *)
  type 'a lan = Lan : ('x J.el -> 'a) * 'x G.el -> 'a lan
  module L = TC1(struct type 'a t = 'a lan end)
  type 'f lhs = { lhs : 'x. 'x G.el -> ('x, 'f) AlongJ.t }
  type 'f rhs = { rhs : 'x. 'x L.el -> ('x, 'f) ap }
  (* (G ~> J↑* F) → (Lan J G ~> F) *)
  let into (type f) (module F : FUNCTOR with type T.co = f) lhs =
    { rhs = fun (Lan (k, g)) -> F.T.co %> F.map k %> F.T.el %> lhs.lhs @@ g }
  (* (G ~> J↑* F) ← (Lan J G ~> F) *)
  let from (type f) (module F : FUNCTOR with type T.co = f) rhs =
    { lhs = fun g -> rhs.rhs (Lan (id, g)) }
end
