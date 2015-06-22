open Sig
open Ty.Sig

module Unit = struct
  module Def : MONOID
    with module T = Semigroup.Unit.Def.T =
  struct
    include Semigroup.Unit.Def
    let unit = ()
  end
  include Def
end

module String = struct
  module Def : MONOID
    with module T = Semigroup.String.Def.T =
  struct
    include Semigroup.String.Def
    let unit = ""
  end
  include Def
end

module Additive = struct
  module Int = struct
    module Def : MONOID
      with module T = Semigroup.Additive.Int.Def.T =
    struct
      include Semigroup.Additive.Int.Def
      let unit = 0
    end
    include Def
  end

  module Float = struct
    module Def : MONOID
      with module T = Semigroup.Additive.Float.Def.T =
    struct
      include Semigroup.Additive.Float.Def
      let unit = 0.0
    end
    include Def
  end
end

module Multiplicative = struct
  module Int = struct
    module Def : MONOID
      with module T = Semigroup.Multiplicative.Int.Def.T =
    struct
      include Semigroup.Multiplicative.Int.Def
      let unit = 1
    end
    include Def
  end

  module Float = struct
    module Def : MONOID
      with module T = Semigroup.Multiplicative.Float.Def.T =
    struct
      include Semigroup.Multiplicative.Float.Def
      let unit = 1.0
    end
    include Def
  end
end

module List = functor (T : Nullary.Invariant.EL) -> struct
  module S = Semigroup.List(T)
  module Def : MONOID
    with module T = S.Def.T =
  struct
    include S.Def
    let unit = []
  end
  include Def
end
