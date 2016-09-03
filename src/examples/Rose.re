open Cats;
let module Rose: {
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
} = {
  let module Def = {
    include Def.Cofree.Make Def.Functor.List;
    include (Def.Comonad.Cofree Def.Functor.List: Sig.COMONAD with module T := T);
    include (Def.Traversable.Cofree Def.Functor.List Def.Traversable.List: Sig.TRAVERSABLE with module T := T);
    let fork x xs => Fork x xs;
    let pure x => Fork x [];
    let rec bind (Fork x xs) k => switch (k x) {
      | Fork x' xs' => Fork x' (List.append xs' @@ List.map (fun x => bind x k) xs)
    };
    let apply mf mx =>
      bind mf @@ fun f =>
      bind mx @@ fun x =>
      pure @@ f x;
  };
  include Def;
  include Ext.Apply.Make Def;
  include Ext.Bind.Make Def;
  include Ext.Comonad.Make Def;
  include Ext.Extend.Make Def;
  include Ext.Foldable.Make Def;
  include Ext.Functor.Make Def;
  include Ext.Monad.Make Def;
  include Ext.Traversable.Make Def;
};
