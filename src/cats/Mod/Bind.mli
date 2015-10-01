open Sig

module Identity : sig
  module Def = Def.Bind.Identity
  module Ext : sig
    include module type of Apply.Identity.Ext
    include module type of Ext.Bind.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
