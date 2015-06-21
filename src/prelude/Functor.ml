module List = struct
  module Def : Sig.FUNCTOR
    with module T = Ty.Con.List.Poly =
  struct
    module T = Ty.Con.List.Poly
    let map = List.map
  end
  include Def
  include Ext.Functor(Def)
end
