open Sig
open TyCon

module List = struct
  module Def = Def.Traversable.List
  module Ext = struct
    include Ext.Traversable.Make(Def)
  end
  include Def
  include Ext
end
