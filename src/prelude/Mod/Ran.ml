open Category.Fun
open Semigroupoid.Fun
open Sig
open Ty
open Ty.Sig.Unary

module Make (J : Covariant.CO) (G : Covariant.CO) = struct
  module J = J
  module G = G
  type 'a ran = { ran : 'x. ('a -> 'x J.el) -> 'x G.el }
  module R = Make.Unary.Covariant(struct type +'a el = 'a ran end)
  type ('x, 'f) pullback = ('x J.el, 'f) Ty.ap
  type 'f lhs = { lhs : 'x. ('x, 'f) pullback -> 'x G.el }
  type 'f rhs = { rhs : 'x. ('x, 'f) Ty.ap -> 'x R.el }
  let into (type f) (module F : FUNCTOR with type T.co = f) lhs =
    { rhs = fun f -> { ran = fun k -> lhs.lhs %> F.T.co %> F.map k %> F.T.el @@ f } }
  let from (type f) (module F : FUNCTOR with type T.co = f) rhs =
    { lhs = fun p -> (rhs.rhs p).ran id }
end
