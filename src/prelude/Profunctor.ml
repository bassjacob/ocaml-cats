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
