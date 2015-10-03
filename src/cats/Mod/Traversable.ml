open Sig
open TyCon

module Cofree
  (FFun : FUNCTOR)
  (FTra : TRAVERSABLE with module T = FFun.T) =
struct
  module Def = Def.Traversable.Cofree(FFun)(FTra)
  module Ext = struct
    include Ext.Foldable.Make(Def)
    include Ext.Traversable.Make(Def)
  end
  include Def
  include Ext
end

module List = struct
  module Def = Def.Traversable.List
  module Ext = struct
    include Ext.Foldable.Make(Def)
    include Ext.Traversable.Make(Def)
  end
  include Def
  include Ext
end
