open Sig
open TyCon

module List : sig
  module Def : FOLDABLE with module T = TC.List
  include (module type of Def)
end

module Option : sig
  module Def : FOLDABLE with module T = TC.Option
  include (module type of Def)
end
