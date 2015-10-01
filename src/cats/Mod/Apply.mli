open Sig
open TyCon

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
