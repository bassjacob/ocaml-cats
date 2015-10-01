open Sig
open TyCon

module List : sig
  module Def = Def.Foldable.List
  module Ext : module type of Ext.Foldable.Make(Def)
  include module type of Def
  include module type of Ext
end

module Option : sig
  module Def = Def.Foldable.Option
  module Ext : module type of Ext.Foldable.Make(Def)
  include module type of Def
  include module type of Ext
end
