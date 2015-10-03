open Sig
open TyCon

module Cofree
    (F :
     sig
       include FOLDABLE
       include FUNCTOR with module T := T
     end) =
struct
  module Def = Def.Foldable.Cofree(F)
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
