open Sig
open TyCon

module Make : functor (J : TC1) (G : TC1) -> sig
  module Def : module type of Def.Ran.Make(J)(G)
  module Ext : sig
    include module type of Ext.Ran.Make(Def)
  end
  include module type of Def
end
