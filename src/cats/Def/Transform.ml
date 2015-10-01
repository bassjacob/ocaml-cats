open Sig
open TyCon

module Make (F : FUNCTOR) (G : FUNCTOR) = struct
  module F = F
  module G = G
  type t = { ap : 'x. 'x F.T.el -> 'x G.T.el }
end
