module Make
  : functor (P : Sig.PROFUNCTOR) -> Sig.END with module Hom := P
  = functor (P : Sig.PROFUNCTOR) ->
struct
  module Hom = P
  type poly = { hom : 'x. ('x, 'x) Hom.T.el }
  type t = poly
  external into : poly -> t = "%identity"
  external from : t -> poly = "%identity"
end
