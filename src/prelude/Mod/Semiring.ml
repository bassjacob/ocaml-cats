open Sig
open Ty

module Unit = struct
  module Def = struct
    module T = Con.Unit
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
    module T = Con.Int
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
    module T = Ty.Con.Float
    let zero = Add.unit
    let add = Add.op
    let one = Mul.unit
    let mul = Mul.op
  end
  include Def
  include Ext.Semiring.Make(Def)
end
