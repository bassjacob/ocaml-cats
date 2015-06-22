open Semigroupoid.Fun
open Sig

module Make
  : functor (G : FUNCTOR) (H : FUNCTOR) -> RAN
  = functor (G : FUNCTOR) (H : FUNCTOR) ->
struct
  module G = G
  module H = H
  type 'a t = { ran : 'x. ('a -> 'x G.T.el) -> 'x H.T.el }
  type 'f nat = { ap : 'x. ('x G.T.el, 'f) Ty.ap -> 'x H.T.el }
  let into (type f) (module F : FUNCTOR with type T.co = f) n f =
    { ran = fun k -> n.ap %> F.T.co %> F.map k %> F.T.el @@ f }
end
