open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Def = Def.Apply.Free(F)
  module Ext = struct
    include Ext.Functor.Make(Def)
    include Ext.Apply.Make(Def)
  end
  include Def
  include Ext
end

module Identity = struct
  module Def = Def.Apply.Identity
  module Ext = struct
    include Functor.Identity.Ext
    include Ext.Apply.Make(Def)
  end
  include Def
  include Ext
end

module Option = struct
  module Def = Def.Apply.Option
  module Ext = struct
    include Functor.Option.Ext
    include Ext.Apply.Make(Def)
  end
  include Def
  include Ext
end

module List = struct
  module Def = Def.Apply.List
  module Ext = struct
    include Functor.List.Ext
    include Ext.Apply.Make(Def)
  end
  include Def
  include Ext
end
