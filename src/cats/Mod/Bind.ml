open Sig

module Free (F : FUNCTOR) = struct
  module Def = Def.Bind.Free(F)
  module Ext = struct
    include Ext.Functor.Make(Def)
    include Ext.Apply.Make(Def)
    include Ext.Bind.Make(Def)
  end
  include Def
  include Ext
end

module Identity = struct
  module Def = Def.Bind.Identity
  module Ext = struct
    include Apply.Identity.Ext
    include Ext.Bind.Make(Def)
  end
  include Def
  include Ext
end
