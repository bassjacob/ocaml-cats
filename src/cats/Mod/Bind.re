open Sig;

let module Free (F: FUNCTOR) => {
  let module Def = Def.Bind.Free F;
  let module Ext = {
    include Ext.Functor.Make Def;
    include Ext.Apply.Make Def;
    include Ext.Bind.Make Def;
  };
  include Def;
  include Ext;
};

let module Identity = {
  let module Def = Def.Bind.Identity;
  let module Ext = {
    include Apply.Identity.Ext;
    include Ext.Bind.Make Def;
  };
  include Def;
  include Ext;
};
