open Sig
open TyCon

module Free (F : FUNCTOR) : sig
  module Def : module type of Def.Apply.Free(F)
  module Ext : sig
    include module type of Ext.Functor.Make(Def)
    include module type of Ext.Apply.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Identity : sig
  module Def = Def.Apply.Identity
  module Ext : sig
    include module type of Functor.Identity.Ext
    include module type of Ext.Apply.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Option : sig
  module Def = Def.Apply.Option
  module Ext : sig
    include module type of Functor.Option.Ext
    include module type of Ext.Apply.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module List : sig
  module Def = Def.Apply.List
  module Ext : sig
    include module type of Functor.List.Ext
    include module type of Ext.Apply.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
