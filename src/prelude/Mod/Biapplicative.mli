open Sig
open TyCon

module Tuple : sig
  module Def : BIAPPLICATIVE with module T = Bifunctor.Tuple.Def.T
  include (module type of Def)
end
