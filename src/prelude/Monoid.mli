open Sig
open Ty.Sig

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

module List : functor (T : Nullary.EL) -> sig
  module Def : MONOID with module T = Semigroup.List(T).Def.T
  include (module type of Def)
end
