open Sig
open TyCon

module Make (E : TC1) = struct
  module Def = Def.Exists.Make(E)
  include Def
end
