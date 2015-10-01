open Sig
open TyCon

module Identity = struct
  module Def = Def.Monad.Identity
  module Ext = struct
    include Apply.Identity.Ext
    include Bind.Identity.Ext
  end
  include Def
  include Ext
end
