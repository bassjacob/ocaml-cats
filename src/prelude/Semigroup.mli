open Sig
open Ty
open Ty.Sig

module Unit : sig
  module Def : SEMIGROUP with module T = Con.Unit
  include (module type of Def)
  include (module type of Ext.Semigroup(Def))
end

module String : sig
  module Def : SEMIGROUP with module T = Con.String
  include (module type of Def)
  include (module type of Ext.Semigroup(Def))
end

module Additive : sig
  module Int : sig
    module Def : SEMIGROUP with module T = Con.Int
    include (module type of Def)
    include (module type of Ext.Semigroup(Def))
  end

  module Float : sig
    module Def : SEMIGROUP with module T = Con.Float
    include (module type of Def)
    include (module type of Ext.Semigroup(Def))
  end
end

module Multiplicative : sig
  module Int : sig
    module Def : SEMIGROUP with module T = Con.Int
    include (module type of Def)
    include (module type of Ext.Semigroup(Def))
  end

  module Float : sig
    module Def : SEMIGROUP with module T = Con.Float
    include (module type of Def)
    include (module type of Ext.Semigroup(Def))
  end
end

module List : functor (T : Nullary.EL) -> sig
  module Def : SEMIGROUP with module T = Con.List.Mono(T)
  include (module type of Def)
end
