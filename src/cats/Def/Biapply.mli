open Sig
open TyCon

module Tuple : sig
  include BIAPPLY with module T = Bifunctor.Tuple.T
end
