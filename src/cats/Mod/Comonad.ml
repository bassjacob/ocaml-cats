open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  module Def = Def.Comonad.Cofree(F)
  module Ext = struct
    include Ext.Functor.Make(Def)
    include Ext.Extend.Make(Def)
    include Ext.Comonad.Make(Def)
  end
  include Def
  include Ext
end
