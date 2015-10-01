open Sig
open TyCon

module Tuple = struct
  module Def = Def.Bitraversable.Tuple
  module Ext = struct
    include Ext.Bitraversable.Make(Def)
  end
  include Def
  include Ext
end
