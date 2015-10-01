open Sig
open TyCon

module Make (E : TC1) = struct
  module Def = Def.Forall.Make(E)
  include Def
end
