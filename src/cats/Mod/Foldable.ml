open Sig
open TyCon

module Cofree
  (FFol : FOLDABLE)
  (FFun : FUNCTOR with module T = FFol.T) =
struct
  module Def = Def.Foldable.Cofree(FFun)(FFol)
  module Ext = Ext.Foldable.Make(Def)
  include Def
  include Ext
end

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
