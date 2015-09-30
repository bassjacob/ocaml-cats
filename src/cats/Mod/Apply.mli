open Sig

module Identity : sig
  module Def : APPLY with module T = Functor.Identity.Def.T
  include (module type of Def)
  include (module type of Ext.Apply.Make(Def))
end

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
