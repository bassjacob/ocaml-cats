open Sig
open TyCon

module Cofree
  (FFun : FUNCTOR)
  (FTra : TRAVERSABLE with module T = FFun.T) :
sig
  module Def : module type of Def.Traversable.Cofree(FFun)(FTra)
  module Ext : sig
    include module type of Ext.Foldable.Make(Def)
    include module type of Ext.Traversable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module List : sig
  module Def = Def.Traversable.List
  module Ext : sig
    include module type of Ext.Foldable.Make(Def)
    include module type of Ext.Traversable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
