module Make
  : functor (E : Ty.Sig.Unary.Invariant.CODE) -> Sig.EXISTENTIAL
      with module T := E
  = functor (E : Ty.Sig.Unary.Invariant.CODE) ->
struct
  module T = E
  type 'r elim = { ap : 'x. 'x T.el -> 'r }
  module Def = struct
    type t = Pack : 'x T.el -> t
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end
