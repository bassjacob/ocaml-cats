open Sig
open TyCon

module Identity : sig
  module Def = Def.Functor.Identity
  module Ext : module type of Ext.Functor.Make(Def)
  include (module type of Def)
  include (module type of Ext)
end

module Option : sig
  module Def = Def.Functor.Option
  module Ext : module type of Ext.Functor.Make(Def)
  include (module type of Def)
  include (module type of Ext)
end

module List : sig
  module Def = Def.Functor.List
  module Ext : module type of Ext.Functor.Make(Def)
  include (module type of Def)
  include (module type of Ext)
end
