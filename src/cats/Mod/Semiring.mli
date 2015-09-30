open Sig
open TyCon

module Unit : sig
  module Def : SEMIRING with module T = TC.Unit
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end

module Int : sig
  module Def : SEMIRING with module T = TC.Int
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end

module Float : sig
  module Def : SEMIRING with module T = TC.Float
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end
