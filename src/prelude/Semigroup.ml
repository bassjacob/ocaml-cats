module Unit = struct
  module Def : Sig.SEMIGROUP
    with module T = Ty.Con.Unit =
  struct
    module T = Ty.Con.Unit
    let op _ _ = ()
  end
  include Def
  include Ext.Semigroup(Def)
end

module String = struct
  module Def : Sig.SEMIGROUP
    with module T = Ty.Con.String =
  struct
    module T = Ty.Con.String
    let op x y = String.concat "" [x; y]
  end
  include Def
  include Ext.Semigroup(Def)
end

module Additive = struct
  module Int = struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.Int =
    struct
      module T = Ty.Con.Int
      let op = (+)
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.Float =
    struct
      module T = Ty.Con.Float
      let op = (+.)
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module Multiplicative = struct
  module Int = struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.Int =
    struct
      module T = Ty.Con.Int
      let op = ( * )
    end
    include Def
    include Ext.Semigroup(Def)
  end

  module Float = struct
    module Def : Sig.SEMIGROUP
      with module T = Ty.Con.Float =
    struct
      module T = Ty.Con.Float
      let op = ( *. )
    end
    include Def
    include Ext.Semigroup(Def)
  end
end

module List = functor (T : Ty.Sig.Nullary.Invariant.ELEM) -> struct
  module Def : Sig.SEMIGROUP
    with module T = Ty.Con.List.Mono(T) =
  struct
    module T = Ty.Con.List.Mono(T)
    let op = List.append
  end
  include Def
end
