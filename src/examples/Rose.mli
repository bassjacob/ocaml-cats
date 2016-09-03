module Def : sig
  include module type of Def.Cofree.Make(Def.Functor.List)
  include Sig.COMONAD with module T := T
  include Sig.FOLDABLE with module T := T
  include Sig.MONAD with module T := T
  include Sig.TRAVERSABLE with module T := T
end

include module type of Def
include module type of Ext.Apply.Make(Def)
include module type of Ext.Bind.Make(Def)
include module type of Ext.Comonad.Make(Def)
include module type of Ext.Extend.Make(Def)
include module type of Ext.Foldable.Make(Def)
include module type of Ext.Functor.Make(Def)
include module type of Ext.Monad.Make(Def)
include module type of Ext.Traversable.Make(Def)
