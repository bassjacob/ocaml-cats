open Category.Fun
open Semigroupoid.Fun
open Sig

module Make (J : FUNCTOR) (G : FUNCTOR) = struct
  module J = J
  module G = G
  type 'a ran = { ran : 'x. ('a -> 'x J.T.el) -> 'x G.T.el }
  type ('x, 'f) pullback = ('x J.T.el, 'f) Ty.ap
  type 'f lhs = { lhs : 'x. ('x, 'f) pullback -> 'x G.T.el }
  type 'f rhs = { rhs : 'x. ('x, 'f) Ty.ap -> 'x ran }
  let into (type f) (module F : FUNCTOR with type T.co = f) lhs =
    { rhs = fun f -> { ran = fun k -> lhs.lhs %> F.T.co %> F.map k %> F.T.el @@ f } }
  let from (type f) (module F : FUNCTOR with type T.co = f) rhs =
    { lhs = fun p -> (rhs.rhs p).ran id }
end
