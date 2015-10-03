open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Def = Def.Applicative.Free(F)
  module Ext = struct
    include Ext.Functor.Make(Def)
    include Ext.Apply.Make(Def)
  end
  include Def
  include Ext
end

module Identity = struct
  module Def = Def.Applicative.Identity
  module Ext = struct
    include Apply.Identity.Ext
  end
  include Def
  include Ext
end

module Option = struct
  module Def = Def.Applicative.Option
  module Ext = struct
    include Apply.Option.Ext
  end
  include Def
  include Ext
end

module List = struct
  module Def = Def.Applicative.List
  module Ext = struct
    include Apply.List.Ext
  end
  include Def
  include Ext
end
