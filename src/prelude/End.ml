open Sig

module Make
  : functor (P : PROFUNCTOR) -> END
      with module Hom := P
  = functor (P : PROFUNCTOR) ->
struct
  module Hom = P
  module Def = struct
    type poly = { hom : 'x. ('x, 'x) Hom.T.el }
    type t = poly
    external into : poly -> t = "%identity"
    external from : t -> poly = "%identity"
  end
  include Def
end
