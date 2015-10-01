open Sig
open TyCon

module List = struct
  module Def = Def.Foldable.List
  module Ext = Ext.Foldable.Make(Def)
  include Def
  include Ext
end

module Option = struct
  module Def = Def.Foldable.Option
  module Ext = Ext.Foldable.Make(Def)
  include Def
  include Ext
end
