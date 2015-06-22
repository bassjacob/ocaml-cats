(* FIXME: consider using Exists for this *)
module Make
  : functor (P : Sig.PROFUNCTOR) -> Sig.COEND
      with module Hom := P
  = functor (P : Sig.PROFUNCTOR) ->
struct
  module Hom = P
  module Def = struct
    type 'r elim = { ap : 'x. ('x, 'x) Hom.T.el -> 'r }
    type t = Pack : ('x, 'x) Hom.T.el -> t
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end
