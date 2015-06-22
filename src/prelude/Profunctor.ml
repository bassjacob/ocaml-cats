module Join
    (* FIXME: is there a better name for this? *)
  : functor (P : Sig.PROFUNCTOR) -> Ty.Sig.Unary.Invariant.CO
  = functor (P : Sig.PROFUNCTOR) ->
struct
  include Ty.Make.Unary.Invariant(struct
    type 'a el = ('a, 'a) P.T.el
  end)
end

module Fun = struct
  module Def : Sig.PROFUNCTOR
    with module T = Ty.Con.Fun.Poly =
  struct
    module T = Ty.Con.Fun.Poly
    let dimap f g h = let (%>) = Ambient.compose in g %> h %> f
  end
  include Def
  include Ext.Profunctor(Def)
end
