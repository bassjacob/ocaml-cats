open Sig
open TyCon

module Tuple : sig
  module Def : PRODUCT with module T = TC.Tuple
  include (module type of Def)
end
