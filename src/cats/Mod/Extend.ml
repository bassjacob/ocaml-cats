open Sig

module Cofree (F : FUNCTOR) = struct
  module Def = Def.Extend.Cofree(F)
  module Ext = struct
    include Ext.Functor.Make(Def)
    include Ext.Extend.Make(Def)
  end
  include Def
  include Ext
end
