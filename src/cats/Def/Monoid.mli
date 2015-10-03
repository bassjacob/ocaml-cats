open Sig
open TyCon

module Endo : functor (A : TC0) -> sig
  include MONOID with module T = Semigroup.Endo(A).T
end

module Flip (M : MONOID) : sig
  include MONOID with module T = Semigroup.Flip(M).T
end

module Any : sig
  include MONOID with module T = Semigroup.Any.T
end

module All : sig
  include MONOID with module T = Semigroup.All.T
end

module Unit : sig
  include MONOID with module T = Semigroup.Unit.T
end

module String : sig
  include MONOID with module T = Semigroup.String.T
end

module Additive : sig
  module Int : sig
    include MONOID with module T = Semigroup.Additive.Int.T
  end

  module Float : sig
    include MONOID with module T = Semigroup.Additive.Float.T
  end
end

module Multiplicative : sig
  module Int : sig
    include MONOID with module T = Semigroup.Multiplicative.Int.T
  end

  module Float : sig
    include MONOID with module T = Semigroup.Multiplicative.Float.T
  end
end

module List : functor (A : TC0) -> sig
  include MONOID with module T = Semigroup.List(A).T
end
