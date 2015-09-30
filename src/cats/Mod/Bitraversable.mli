open Sig

module Tuple : sig
  module Def : BITRAVERSABLE with module T = Bifunctor.Tuple.Def.T
  include (module type of Def)
end
