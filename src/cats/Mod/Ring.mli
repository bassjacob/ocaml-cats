open Sig

module Unit : sig
  module Def : RING with module T = Semiring.Unit.Def.T
  include (module type of Def)
  include (module type of Ext.Ring.Make(Def))
end

module Int : sig
  module Def : RING with module T = Semiring.Int.Def.T
  include (module type of Def)
  include (module type of Ext.Ring.Make(Def))
end

module Float : sig
  module Def : RING with module T = Semiring.Float.Def.T
  include (module type of Def)
  include (module type of Ext.Ring.Make(Def))
end
