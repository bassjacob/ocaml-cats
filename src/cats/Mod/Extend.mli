open Sig

module Cofree (F : FUNCTOR) : sig
  module Def : module type of Def.Extend.Cofree(F)
  module Ext : sig
    include module type of Ext.Functor.Make(Def)
    include module type of Ext.Extend.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
