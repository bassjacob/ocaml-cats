open Cats;

let module Def: {
  include module type Def.Cofree.Make Def.Functor.List;
  include Sig.COMONAD with module T := T;
  include Sig.FOLDABLE with module T := T;
  include Sig.MONAD with module T := T;
  include Sig.TRAVERSABLE with module T := T;
};
include module type Def;
include module type Ext.Apply.Make Def;
include module type Ext.Bind.Make Def;
include module type Ext.Comonad.Make Def;
include module type Ext.Extend.Make Def;
include module type Ext.Foldable.Make Def;
include module type Ext.Functor.Make Def;
include module type Ext.Monad.Make Def;
include module type Ext.Traversable.Make Def;
