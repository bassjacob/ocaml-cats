open Sig

module List : sig
  module Def : APPLICATIVE with module T = Functor.List.Def.T
  include (module type of Def)
end
