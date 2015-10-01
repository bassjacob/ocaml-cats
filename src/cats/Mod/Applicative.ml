open Sig
open TyCon

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
