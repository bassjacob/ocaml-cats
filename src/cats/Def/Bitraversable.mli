open Sig

module Tuple : sig
  include BITRAVERSABLE with module T = Bifunctor.Tuple.T
end
