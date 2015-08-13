open Sig
open TyCon

module Identity : sig
  module Def : FUNCTOR with module T = TC.Identity
  include (module type of Def)
  include (module type of Ext.Functor.Make(Def))
end

module Option : sig
  module Def : FUNCTOR with module T = TC.Option
  include (module type of Def)
  include (module type of Ext.Functor.Make(Def))
end

module List : sig
  module Def : FUNCTOR with module T = TC.List
  include (module type of Def)
  include (module type of Ext.Functor.Make(Def))
end
