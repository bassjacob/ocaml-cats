open Sig
open TyCon

module Unit = struct
  module T = TC.Unit

  let zero = ()
  let add _ _ = ()
  let one = ()
  let mul _ _ = ()
end

module Int = struct
  module Add = Monoid.Additive.Int
  module Mul = Monoid.Multiplicative.Int

  module T = TC.Int

  let zero = Add.unit
  let add = Add.op
  let one = Mul.unit
  let mul = Mul.op
end

module Float = struct
  module Add = Monoid.Additive.Float
  module Mul = Monoid.Multiplicative.Float

  module T = TC.Float

  let zero = Add.unit
  let add = Add.op
  let one = Mul.unit
  let mul = Mul.op
end
