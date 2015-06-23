open Sig
open Ty

module List : sig
  module Def : FOLDABLE with module T = Con.List.Poly
  include (module type of Def)
end

module Option : sig
  module Def : FOLDABLE with module T = Con.Option.Poly
  include (module type of Def)
end
