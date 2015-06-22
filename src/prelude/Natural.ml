open Sig

module Make
  : functor (F : FUNCTOR) (G : FUNCTOR) -> NATURAL
      with module F := F
       and module G := G
  = functor (F : FUNCTOR) (G : FUNCTOR) ->
struct
  module F = F
  module G = G
  type t = { ap : 'x. 'x F.T.el -> 'x G.T.el }
  let nat n = n.ap
end
