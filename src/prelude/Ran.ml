open Semigroupoid.Fun

module Make
  : functor (G : Sig.FUNCTOR) (H : Sig.FUNCTOR) -> Sig.RAN
  = functor (G : Sig.FUNCTOR) (H : Sig.FUNCTOR) ->
struct
  module G = G
  module H = H
  type 'a t = { ran : 'x. ('a -> 'x G.T.el) -> 'x H.T.el }
  type 'f nat = { ap : 'x. ('x G.T.el, 'f) Ty.ap -> 'x H.T.el }
  let into (type f) (module F : Sig.FUNCTOR with type T.co = f) n f =
    { ran = fun k -> n.ap %> F.T.co %> F.map k %> F.T.el @@ f }
end
