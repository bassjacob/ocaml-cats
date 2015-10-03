open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Def = Def.Monad.Free(F)
  module Ext = struct
    include Ext.Apply.Make(Def)
    include Ext.Bind.Make(Def)
    include Ext.Functor.Make(Def)
    include Ext.Monad.Make(Def)
  end
  include Def
  include Ext
end

module Identity = struct
  module Def = Def.Monad.Identity
  module Ext = struct
    include Apply.Identity.Ext
    include Bind.Identity.Ext
    include Ext.Monad.Make(Def)
  end
  include Def
  include Ext
end
