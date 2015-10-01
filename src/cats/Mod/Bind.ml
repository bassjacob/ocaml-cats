open Sig

module Identity = struct
  module Def = Def.Bind.Identity
  module Ext = struct
    include Apply.Identity.Ext
    include Ext.Bind.Make(Def)
  end
  include Def
  include Ext
end
