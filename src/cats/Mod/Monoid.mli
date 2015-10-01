open Sig
open TyCon

module Endo : functor (A : TC0) -> sig
  module Def : MONOID with module T = Semigroup.Endo(A).Def.T
  include (module type of Def)
end

module Flip (M : MONOID) : sig
  module Def : MONOID with module T = Semigroup.Flip(M).Def.T
  include (module type of Def)
end

module Unit : sig
  module Def : MONOID with module T = Semigroup.Unit.Def.T
  include (module type of Def)
end

module String : sig
  module Def : MONOID with module T = Semigroup.String.Def.T
  include (module type of Def)
end

module Additive : sig
  module Int : sig
    module Def : MONOID with module T = Semigroup.Additive.Int.Def.T
    include (module type of Def)
  end

  module Float : sig
    module Def : MONOID with module T = Semigroup.Additive.Float.Def.T
    include (module type of Def)
  end
end

module Multiplicative : sig
  module Int : sig
    module Def : MONOID with module T = Semigroup.Multiplicative.Int.Def.T
    include (module type of Def)
  end

  module Float : sig
    module Def : MONOID with module T = Semigroup.Multiplicative.Float.Def.T
    include (module type of Def)
  end
end

module List : functor (A : TC0) -> sig
  module Def : MONOID with module T = Semigroup.List(A).Def.T
  include (module type of Def)
end
