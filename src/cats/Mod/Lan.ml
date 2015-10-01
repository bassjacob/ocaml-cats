open Sig
open TyCon

module Make (J : TC1) (G : TC1) = struct
  module Def = Def.Lan.Make(J)(G)
  module Ext = struct
    include Ext.Lan.Make(Def)
  end
  include Def
  include Ext
end
