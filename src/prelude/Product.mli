open Sig
open Ty

module Tuple : sig
  module Def : PRODUCT with module T = Con.Tuple.Poly
  include (module type of Def)
end
