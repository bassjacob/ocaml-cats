open Sig
open TyCon

module Tuple : sig
  include PRODUCT with module T = TC.Tuple
end
