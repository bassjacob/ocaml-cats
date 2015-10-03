open Sig
open TyCon

module Endo (A : TC0) = struct
  include Semigroup.Endo(A)
  let unit = Amb.id
end

module Flip (M : MONOID) = struct
  include Semigroup.Flip(M)
  let unit = M.unit
end

module Any = struct
  include Semigroup.Any
  let unit = false
end

module All = struct
  include Semigroup.All
  let unit = true
end

module Unit = struct
  include Semigroup.Unit
  let unit = ()
end

module String = struct
  include Semigroup.String
  let unit = ""
end

module Additive = struct
  module Int = struct
    include Semigroup.Additive.Int
    let unit = 0
  end

  module Float = struct
    include Semigroup.Additive.Float
    let unit = 0.0
  end
end

module Multiplicative = struct
  module Int = struct
    include Semigroup.Multiplicative.Int
    let unit = 1
  end

  module Float = struct
    include Semigroup.Multiplicative.Float
    let unit = 1.0
  end
end

module List (T : TC0) = struct
  include Semigroup.List(T)
  let unit = []
end
