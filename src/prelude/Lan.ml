open Semigroupoid.Fun

module Make
  : functor (G : Sig.FUNCTOR) (H : Sig.FUNCTOR) -> Sig.LAN
  = functor (G : Sig.FUNCTOR) (H : Sig.FUNCTOR) ->
struct
  module G = G
  module H = H
  type 'a t = Lan : ('x G.T.el -> 'a) * 'x H.T.el -> 'a t
  type 'f nat = { ap : 'x. 'x H.T.el -> ('x G.T.el, 'f) Ty.ap }
  let into (type f) (module F : Sig.FUNCTOR with type T.tc = f) n e =
    match e with
    | Lan (f, x) -> F.T.code %> F.map f %> F.T.elem %> n.ap @@ x
end
