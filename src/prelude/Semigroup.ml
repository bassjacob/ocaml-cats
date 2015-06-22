open Sig
open Ty
open Ty.Sig

module Unit = struct
  module Def = struct
    module T = Con.Unit
    let op _ _ = ()
  end
  include Def
  include Ext.Semigroup(Def)
end

module String = struct
  module Def = struct
    module T = Con.String
    let op x y = String.concat "" [x; y]
  end
  include Def
  include Ext.Semigroup(Def)
end

module Additive = struct
  module Int = struct
    module Def = struct
      module T = Con.Int
      let op = (+)
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def = struct
      module T = Con.Float
      let op = (+.)
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module Multiplicative = struct
  module Int = struct
    module Def = struct
      module T = Con.Int
      let op = ( * )
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def = struct
      module T = Con.Float
      let op = ( *. )
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module List (T : Nullary.EL) = struct
  module Def = struct
    module T = Con.List.Mono(T)
    let op = List.append
  end
  include Def
end
