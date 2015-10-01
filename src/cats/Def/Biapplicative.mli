open Sig
open TyCon

module Tuple : sig
  include BIAPPLICATIVE with module T = Bifunctor.Tuple.T
end
