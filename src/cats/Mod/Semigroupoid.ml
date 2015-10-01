open Sig

module Fun = struct
  module Def = Def.Semigroupoid.Fun
  module Ext = struct
    include Profunctor.Fun.Ext
    include Ext.Semigroupoid.Make(Def)
  end
  include Def
  include Ext
end
