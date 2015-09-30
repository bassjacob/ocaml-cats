open Sig

module Identity : sig
  module Def : APPLICATIVE with module T = Functor.Identity.Def.T
  include (module type of Def)
end

module Option : sig
  module Def : APPLICATIVE with module T = Functor.Option.Def.T
  include (module type of Def)
end

module List : sig
  module Def : APPLICATIVE with module T = Functor.List.Def.T
  include (module type of Def)
end
