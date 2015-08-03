open Category.Fun
open Semigroupoid.Fun
open Sig

module Make (J : FUNCTOR) (G : FUNCTOR) = struct
  module J = J
  module G = G
  type 'a lan = Lan : ('x J.T.el -> 'a) * 'x G.T.el -> 'a lan
  type ('x, 'f) pullback = ('x J.T.el, 'f) Ty.ap
  type 'f lhs = { lhs : 'x. 'x G.T.el -> ('x, 'f) pullback }
  type 'f rhs = { rhs : 'x. 'x lan -> ('x, 'f) Ty.ap }
  let into (type f) (module F : FUNCTOR with type T.co = f) lhs =
    { rhs = fun (Lan (k, g)) -> F.T.co %> F.map k %> F.T.el %> lhs.lhs @@ g }
  let from (type f) (module F : FUNCTOR with type T.co = f) rhs =
    { lhs = fun g -> rhs.rhs (Lan (id, g)) }
end
