open Sig
open TyCon

module Tuple : sig
  module Def : BIAPPLY with module T = Bifunctor.Tuple.Def.T
  include (module type of Def)
end
