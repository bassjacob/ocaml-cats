open Sig
open TyCon

module Unit : sig
  module Def : SEMIGROUP with module T = TC.Unit
  include (module type of Def)
  include (module type of Ext.Semigroup.Make(Def))
end

module String : sig
  module Def : SEMIGROUP with module T = TC.String
  include (module type of Def)
  include (module type of Ext.Semigroup.Make(Def))
end

module Additive : sig
  module Int : sig
    module Def : SEMIGROUP with module T = TC.Int
    include (module type of Def)
    include (module type of Ext.Semigroup.Make(Def))
  end

  module Float : sig
    module Def : SEMIGROUP with module T = TC.Float
    include (module type of Def)
    include (module type of Ext.Semigroup.Make(Def))
  end
end

module Multiplicative : sig
  module Int : sig
    module Def : SEMIGROUP with module T = TC.Int
    include (module type of Def)
    include (module type of Ext.Semigroup.Make(Def))
  end

  module Float : sig
    module Def : SEMIGROUP with module T = TC.Float
    include (module type of Def)
    include (module type of Ext.Semigroup.Make(Def))
  end
end

module List : functor (X : TC0) -> sig
  module Def : SEMIGROUP with type T.el = X.el TC.List.el
  include (module type of Def)
end
