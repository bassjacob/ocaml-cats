open Sig

module Fun : sig
  module Def = Def.Semigroupoid.Fun
  module Ext : sig
    include module type of Profunctor.Fun.Ext
    include module type of Ext.Semigroupoid.Make(Def)
  end
  include (module type of Def)
  include (module type of Ext)
end
