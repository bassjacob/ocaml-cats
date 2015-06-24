open Sig

module Option : sig
  module Def : APPLY with module T = Functor.Option.Def.T
  include (module type of Def)
  include (module type of Ext.Apply.Make(Def))
end

module List : sig
  module Def : APPLY with module T = Functor.List.Def.T
  include (module type of Def)
  include (module type of Ext.Apply.Make(Def))
end
