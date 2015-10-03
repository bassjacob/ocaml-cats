open Sig
open TyCon

module Endo (A : TC0) = struct
  module Def = Def.Monoid.Endo(A)
  module Ext = struct
    module Super = Semigroup.Endo(A)
    include Super.Ext
  end
  include Def
  include Ext
end

module Flip (M : MONOID) = struct
  module Def = Def.Monoid.Flip(M)
  module Ext = struct
    module Super = Semigroup.Flip(M)
    include Super.Ext
  end
  include Def
  include Ext
end

module Any = struct
  module Def = Def.Monoid.Any
  module Ext = struct
    include Semigroup.Any.Ext
  end
  include Def
  include Ext
end

module All = struct
  module Def = Def.Monoid.All
  module Ext = struct
    include Semigroup.All.Ext
  end
  include Def
  include Ext
end

module Unit = struct
  module Def = Def.Monoid.Unit
  module Ext = struct
    include Semigroup.Unit.Ext
  end
  include Def
  include Ext
end

module String = struct
  module Def = Def.Monoid.String
  module Ext = struct
    include Semigroup.String.Ext
  end
  include Def
  include Ext
end

module Additive = struct
  module Int = struct
    module Def = Def.Monoid.Additive.Int
    module Ext = struct
      include Semigroup.Additive.Int.Ext
    end
    include Def
    include Ext
  end

  module Float = struct
    module Def = Def.Monoid.Additive.Float
    module Ext = struct
      include Semigroup.Additive.Float.Ext
    end
    include Def
    include Ext
  end
end

module Multiplicative = struct
  module Int = struct
    module Def = Def.Monoid.Multiplicative.Int
    module Ext = struct
      include Semigroup.Multiplicative.Int.Ext
    end
    include Def
    include Ext
  end

  module Float = struct
    module Def = Def.Monoid.Multiplicative.Float
    module Ext = struct
      include Semigroup.Multiplicative.Float.Ext
    end
    include Def
    include Ext
  end
end

module List (T : TC0) = struct
  module Def = Def.Monoid.List(T)
  module Ext = struct
    module Super = Semigroup.List(T)
    include Super.Ext
  end
  include Def
  include Ext
end
