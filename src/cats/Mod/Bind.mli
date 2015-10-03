open Sig

module Free (F : FUNCTOR) : sig
  module Def : module type of Def.Bind.Free(F)
  module Ext : sig
    include module type of Ext.Functor.Make(Def)
    include module type of Ext.Apply.Make(Def)
    include module type of Ext.Bind.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Identity : sig
  module Def = Def.Bind.Identity
  module Ext : sig
    include module type of Apply.Identity.Ext
    include module type of Ext.Bind.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
