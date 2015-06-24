open Sig
open Ty

module Variant : sig
  module Def : COPRODUCT with module T = Con.Variant.Poly
  include (module type of Def)
end
