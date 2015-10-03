open Sig
open TyCon

module Endo (A : TC0) = struct
  module Def = Def.Semigroup.Endo(A)
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module Flip (M : SEMIGROUP) = struct
  module Def = Def.Semigroup.Flip(M)
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module Any = struct
  module Def = Def.Semigroup.Any
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module All = struct
  module Def = Def.Semigroup.All
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module Unit = struct
  module Def = Def.Semigroup.Unit
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module String = struct
  module Def = Def.Semigroup.String
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end

module Additive = struct
  module Int = struct
    module Def = Def.Semigroup.Additive.Int
    module Ext = Ext.Semigroup.Make(Def)
    include Def
    include Ext
  end

  module Float = struct
    module Def = Def.Semigroup.Additive.Float
    module Ext = Ext.Semigroup.Make(Def)
    include Def
    include Ext
  end
end

module Multiplicative = struct
  module Int = struct
    module Def = Def.Semigroup.Multiplicative.Int
    module Ext = Ext.Semigroup.Make(Def)
    include Def
    include Ext
  end

  module Float = struct
    module Def = Def.Semigroup.Multiplicative.Float
    module Ext = Ext.Semigroup.Make(Def)
    include Def
    include Ext
  end
end

module List (A : TC0) = struct
  module Def = Def.Semigroup.List(A)
  module Ext = Ext.Semigroup.Make(Def)
  include Def
  include Ext
end
