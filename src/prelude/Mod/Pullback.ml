open Sig
open TyCon

(* pullback (along J) *)
module Make (J : TC1) = struct
  module J = J
  (* J↑* f ≅ f ∘ J *)
  type ('x, 'f) t = ('x J.el, 'f) ap
end
