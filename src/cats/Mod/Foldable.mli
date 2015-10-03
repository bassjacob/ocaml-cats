open Sig
open TyCon

module Cofree
    (F :
     sig
       include FOLDABLE
       include FUNCTOR with module T := T
     end) :
sig
  module Def : module type of Def.Foldable.Cofree(F)
  module Ext : module type of Ext.Foldable.Make(Def)
  include module type of Def
  include module type of Ext
end

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
