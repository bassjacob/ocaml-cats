open Sig
open TyCon

module Identity : sig
  module Def = Def.Monad.Identity
  module Ext : sig
    include module type of Apply.Identity.Ext
    include module type of Bind.Identity.Ext
  end
  include module type of Def
  include module type of Ext
end
