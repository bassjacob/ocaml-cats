open Sig
open Ty
open Ty.Sig

module Unit = struct
  module Def : SEMIGROUP
    with module T = Con.Unit =
  struct
    module T = Con.Unit
    let op _ _ = ()
  end
  include Def
  include Ext.Semigroup(Def)
end

module String = struct
  module Def : SEMIGROUP
    with module T = Con.String =
  struct
    module T = Con.String
    let op x y = String.concat "" [x; y]
  end
  include Def
  include Ext.Semigroup(Def)
end

module Additive = struct
  module Int = struct
    module Def : SEMIGROUP
      with module T = Con.Int =
    struct
      module T = Con.Int
      let op = (+)
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def : SEMIGROUP
      with module T = Con.Float =
    struct
      module T = Con.Float
      let op = (+.)
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module Multiplicative = struct
  module Int = struct
    module Def : SEMIGROUP
      with module T = Con.Int =
    struct
      module T = Con.Int
      let op = ( * )
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def : SEMIGROUP
      with module T = Con.Float =
    struct
      module T = Con.Float
      let op = ( *. )
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module List = functor (T : Nullary.Invariant.EL) -> struct
  module Def : SEMIGROUP
    with module T = Con.List.Mono(T) =
  struct
    module T = Con.List.Mono(T)
    let op = List.append
  end
  include Def
end
