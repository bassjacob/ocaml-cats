open Sig
open TyCon

module Endo (A : TC0) = struct
  module Dep = Semigroup.Endo(A)
  module Def = struct
    include Dep.Def
    let unit = Amb.id
  end
  include Def
end

module Flip (M : MONOID) = struct
  module Dep = Semigroup.Flip(M)
  module Def = struct
    include Dep.Def
    let unit = M.unit
  end
  include Def
end

module Unit = struct
  module Def = struct
    include Semigroup.Unit.Def
    let unit = ()
  end
  include Def
end

module String = struct
  module Def = struct
    include Semigroup.String.Def
    let unit = ""
  end
  include Def
end

module Additive = struct
  module Int = struct
    module Def = struct
      include Semigroup.Additive.Int.Def
      let unit = 0
    end
    include Def
  end

  module Float = struct
    module Def = struct
      include Semigroup.Additive.Float.Def
      let unit = 0.0
    end
    include Def
  end
end

module Multiplicative = struct
  module Int = struct
    module Def = struct
      include Semigroup.Multiplicative.Int.Def
      let unit = 1
    end
    include Def
  end

  module Float = struct
    module Def = struct
      include Semigroup.Multiplicative.Float.Def
      let unit = 1.0
    end
    include Def
  end
end

module List (T : TC0) = struct
  module Dep = Semigroup.List(T)
  module Def = struct
    include Dep.Def
    let unit = []
  end
  include Def
end
