open Ambient
open Sig
open Ty

module Tuple = struct
  open Ambient
  module Def : PRODUCT
    with module T = Con.Tuple.Poly =
  struct
    include Bifunctor.Tuple.Def
    include Ambient.Product
  end
  include Def
end
