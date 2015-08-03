open Category.Fun
open Semigroupoid.Fun
open Sig
open Ty
open Ty.Sig.Unary

module Make (J : Covariant.CO) (G : Covariant.CO) = struct
  module J = J
  module G = G
  type +'a lan = Lan : ('x J.el -> 'a) * 'x G.el -> 'a lan
  module L = Make.Unary.Covariant(struct type +'a el = 'a lan end)
  type ('x, 'f) pullback = ('x J.el, 'f) Ty.ap
  type 'f lhs = { lhs : 'x. 'x G.el -> ('x, 'f) pullback }
  type 'f rhs = { rhs : 'x. 'x L.el -> ('x, 'f) Ty.ap }
  let into (type f) (module F : FUNCTOR with type T.co = f) lhs =
    { rhs = fun (Lan (k, g)) -> F.T.co %> F.map k %> F.T.el %> lhs.lhs @@ g }
  let from (type f) (module F : FUNCTOR with type T.co = f) rhs =
    { lhs = fun g -> rhs.rhs (Lan (id, g)) }
end
