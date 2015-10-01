open Sig
open TyCon

module Endo : functor (A : TC0) -> sig
  include SEMIGROUP with type T.el = A.el -> A.el
end

module Flip (M : SEMIGROUP) : sig
  include SEMIGROUP with module T = M.T
end

module Unit : sig
  include SEMIGROUP with module T = TC.Unit
end

module String : sig
  include SEMIGROUP with module T = TC.String
end

module Additive : sig
  module Int : sig
    include SEMIGROUP with module T = TC.Int
  end

  module Float : sig
    include SEMIGROUP with module T = TC.Float
  end
end

module Multiplicative : sig
  module Int : sig
    include SEMIGROUP with module T = TC.Int
  end

  module Float : sig
    include SEMIGROUP with module T = TC.Float
  end
end

module List : functor (X : TC0) -> sig
  include SEMIGROUP with type T.el = X.el TC.List.el
end
