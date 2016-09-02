open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Def = Def.Monad.Free F;
  let module Ext = {
    include Ext.Apply.Make Def;
    include Ext.Bind.Make Def;
    include Ext.Functor.Make Def;
    include Ext.Monad.Make Def;
  };
  include Def;
  include Ext;
};

let module Identity = {
  let module Def = Def.Monad.Identity;
  let module Ext = {
    include Apply.Identity.Ext;
    include Bind.Identity.Ext;
    include Ext.Monad.Make Def;
  };
  include Def;
  include Ext;
};
