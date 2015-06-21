module Fun = struct
  module Def : Sig.CATEGORY
    with module T = Semigroupoid.Fun.Def.T =
  struct
    include Semigroupoid.Fun.Def
    let id = Ambient.id
  end
  include Def
end
