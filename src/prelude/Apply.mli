open Sig

module List : sig
  module Def : APPLY with module T = Functor.List.Def.T
  include (module type of Def)
  include (module type of Ext.Apply(Def))
end
