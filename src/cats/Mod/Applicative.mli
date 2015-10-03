open Sig
open TyCon

module Free (F : FUNCTOR) : sig
  module Def : module type of Def.Applicative.Free(F)
  module Ext : sig
    include module type of Ext.Functor.Make(Def)
    include module type of Ext.Apply.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Identity : sig
  module Def = Def.Applicative.Identity
  module Ext : sig
    include module type of Apply.Identity.Ext
  end
  include module type of Def
  include module type of Ext
end

module Option : sig
  module Def = Def.Applicative.Option
  module Ext : sig
    include module type of Apply.Option.Ext
  end
  include module type of Def
end

module List : sig
  module Def = Def.Applicative.List
  module Ext : sig
    include module type of Apply.List.Ext
  end
  include module type of Def
  include module type of Ext
end
