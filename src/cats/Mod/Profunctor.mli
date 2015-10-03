open Sig
open TyCon

module Diagonal : functor (P : PROFUNCTOR) ->
  module type of Def.Profunctor.Diagonal(P)

module Fun : sig
  module Def = Def.Profunctor.Fun
  module Ext : module type of Ext.Profunctor.Make(Def)
  include module type of Def
  include module type of Ext
end
