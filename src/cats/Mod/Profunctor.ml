open Sig
open TyCon

module Diagonal (P : PROFUNCTOR) = Def.Profunctor.Diagonal(P)

module Fun = struct
  module Def = Def.Profunctor.Fun
  module Ext = Ext.Profunctor.Make(Def)
  include Def
  include Ext
end
