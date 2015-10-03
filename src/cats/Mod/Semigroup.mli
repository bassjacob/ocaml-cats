open Sig
open TyCon

module Endo : functor (A : TC0) -> sig
  module Def : module type of Def.Semigroup.Endo(A)
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module Flip (M : SEMIGROUP) : sig
  module Def : module type of Def.Semigroup.Flip(M)
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module Any : sig
  module Def = Def.Semigroup.Any
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module All : sig
  module Def = Def.Semigroup.All
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module Unit : sig
  module Def = Def.Semigroup.Unit
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module String : sig
  module Def = Def.Semigroup.String
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end

module Additive : sig
  module Int : sig
    module Def = Def.Semigroup.Additive.Int
    module Ext : module type of Ext.Semigroup.Make(Def)
    include module type of Def
    include module type of Ext
  end

  module Float : sig
    module Def = Def.Semigroup.Additive.Float
    module Ext : module type of Ext.Semigroup.Make(Def)
    include module type of Def
    include module type of Ext
  end
end

module Multiplicative : sig
  module Int : sig
    module Def = Def.Semigroup.Multiplicative.Int
    module Ext : module type of Ext.Semigroup.Make(Def)
    include module type of Def
    include module type of Ext
  end

  module Float : sig
    module Def = Def.Semigroup.Multiplicative.Float
    module Ext : module type of Ext.Semigroup.Make(Def)
    include module type of Def
    include module type of Ext
  end
end

module List : functor (A : TC0) -> sig
  module Def : module type of Def.Semigroup.List(A)
  module Ext : module type of Ext.Semigroup.Make(Def)
  include module type of Def
  include module type of Ext
end
