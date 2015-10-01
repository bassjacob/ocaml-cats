open Sig
open TyCon

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
