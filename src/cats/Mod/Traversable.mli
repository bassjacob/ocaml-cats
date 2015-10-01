open Sig
open TyCon

module List : sig
  module Def = Def.Traversable.List
  module Ext : sig
    include module type of Ext.Traversable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
