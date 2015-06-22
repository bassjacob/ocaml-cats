open Semigroupoid.Fun
open Sig

module Make
  : functor (G : FUNCTOR) (H : FUNCTOR) -> LAN
  = functor (G : FUNCTOR) (H : FUNCTOR) ->
struct
  module G = G
  module H = H
  type 'a t = Lan : ('x G.T.el -> 'a) * 'x H.T.el -> 'a t
  type 'f nat = { ap : 'x. 'x H.T.el -> ('x G.T.el, 'f) Ty.ap }
  let into (type f) (module F : FUNCTOR with type T.co = f) n e =
    match e with
    | Lan (a, h) -> F.T.co %> F.map a %> F.T.el %> n.ap @@ h
end
