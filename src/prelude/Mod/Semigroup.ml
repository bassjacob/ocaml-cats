open Sig
open TyCon

module Unit = struct
  module Def = struct
    module T = TC.Unit
    let op _ _ = ()
  end
  include Def
  include Ext.Semigroup.Make(Def)
end

module String = struct
  module Def = struct
    module T = TC.String
    let op x y = String.concat "" [x; y]
  end
  include Def
  include Ext.Semigroup.Make(Def)
end

module Additive = struct
  module Int = struct
    module Def = struct
      module T = TC.Int
      let op = (+)
    end
    include Def
    include Ext.Semigroup.Make(Def)
  end

  module Float = struct
    module Def = struct
      module T = TC.Float
      let op = (+.)
    end
    include Def
    include Ext.Semigroup.Make(Def)
  end
end

module Multiplicative = struct
  module Int = struct
    module Def = struct
      module T = TC.Int
      let op = ( * )
    end
    include Def
    include Ext.Semigroup.Make(Def)
  end

  module Float = struct
    module Def = struct
      module T = TC.Float
      let op = ( *. )
    end
    include Def
    include Ext.Semigroup.Make(Def)
  end
end

module List (X : TC0) = struct
  module Def = struct
    module T = TC0(struct type t = X.el TC.List.el end)
    let op = List.append
  end
  include Def
end
