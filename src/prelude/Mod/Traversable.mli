open Sig

module List : sig
  module Def : TRAVERSABLE with module T = Functor.List.Def.T
  include (module type of Def)
end
