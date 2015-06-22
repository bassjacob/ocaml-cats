open Sig
open Ty

module Tuple : sig
  module Def : BIFUNCTOR with module T = Con.Tuple.Poly
  include (module type of Def)
end

module Variant : sig
  module Def : BIFUNCTOR with module T = Con.Variant.Poly
  include (module type of Def)
end
