open Sig
open TyCon

module Unit = struct
  module Def = struct
    module T = TC.Unit
    let zero = ()
    let add _ _ = ()
    let one = ()
    let mul _ _ = ()
  end
  include Def
  include Ext.Semiring.Make(Def)
end

module Int = struct
  module Def = struct
    module Add = Monoid.Additive.Int.Def
    module Mul = Monoid.Multiplicative.Int.Def
    module T = TC.Int
    let zero = Add.unit
    let add = Add.op
    let one = Mul.unit
    let mul = Mul.op
  end
  include Def
  include Ext.Semiring.Make(Def)
end

module Float = struct
  module Def = struct
    module Add = Monoid.Additive.Float.Def
    module Mul = Monoid.Multiplicative.Float.Def
    module T = TC.Float
    let zero = Add.unit
    let add = Add.op
    let one = Mul.unit
    let mul = Mul.op
  end
  include Def
  include Ext.Semiring.Make(Def)
end
