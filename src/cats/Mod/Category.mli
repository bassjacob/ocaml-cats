open Sig
open TyCon

module Fun : sig
  module Def = Def.Category.Fun
  include module type of Def
end
