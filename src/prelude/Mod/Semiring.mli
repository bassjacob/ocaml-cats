open Sig
open Ty

module Unit : sig
  module Def : SEMIRING with module T = Con.Unit
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end

module Int : sig
  module Def : SEMIRING with module T = Con.Int
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end

module Float : sig
  module Def : SEMIRING with module T = Con.Float
  include (module type of Def)
  include (module type of Ext.Semiring.Make(Def))
end
