open Sig
open TyCon

module Endo : functor (A : TC0) -> sig
  module Def : module type of Def.Monoid.Endo(A)
  module Ext : sig
    (* include module type of Semigroup.Endo(A).Ext *)
  end
  include (module type of Def)
  include (module type of Ext)
end

module Flip (M : MONOID) : sig
  module Def : MONOID with module T = Def.Monoid.Flip(M).T
  module Ext : sig
    (* include Semigroup.Flip(M).Ext *)
  end
  include (module type of Def)
  include (module type of Ext)
end

module Unit : sig
  module Def : MONOID with module T = Def.Monoid.Unit.T
  module Ext : sig
    include module type of Semigroup.Unit.Ext
  end
  include (module type of Def)
  include (module type of Ext)
end

module String : sig
  module Def : MONOID with module T = Def.Monoid.String.T
  module Ext : sig
    include module type of Semigroup.String.Ext
  end
  include (module type of Def)
  include (module type of Ext)
end

module Additive : sig
  module Int : sig
    module Def : MONOID with module T = Def.Monoid.Additive.Int.T
    module Ext : sig
      include module type of Semigroup.Additive.Int.Ext
    end
    include (module type of Def)
    include (module type of Ext)
  end

  module Float : sig
    module Def : MONOID with module T = Def.Monoid.Additive.Float.T
    module Ext : sig
      include module type of Semigroup.Additive.Float.Ext
    end
    include (module type of Def)
    include (module type of Ext)
  end
end

module Multiplicative : sig
  module Int : sig
    module Def : MONOID with module T = Def.Monoid.Multiplicative.Int.T
    module Ext : sig
      include module type of Semigroup.Multiplicative.Int.Ext
    end
    include (module type of Def)
    include (module type of Ext)
  end

  module Float : sig
    module Def : MONOID with module T = Def.Monoid.Multiplicative.Float.T
    module Ext : sig
      include module type of Semigroup.Multiplicative.Float.Ext
    end
    include (module type of Def)
    include (module type of Ext)
  end
end

module List : functor (A : TC0) -> sig
  module Def : MONOID with module T = Def.Monoid.List(A).T
  module Ext : sig
    (* include module type of Semigroup.List.Ext *)
  end
  include (module type of Def)
  include (module type of Ext)
end
