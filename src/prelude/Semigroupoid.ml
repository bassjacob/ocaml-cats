module Fun = struct
  module Def : Sig.SEMIGROUPOID
    with module T = Profunctor.Fun.Def.T =
  struct
    include Profunctor.Fun.Def
    let compose = Ambient.compose
  end
  include Def
  include Ext.Semigroupoid(Def)
end
