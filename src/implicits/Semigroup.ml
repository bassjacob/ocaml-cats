open Prelude.Sig

let op (implicit M : SEMIGROUP) = M.op

implicit module Unit = Prelude.Semigroup.Unit
implicit module String = Prelude.Semigroup.String

module Additive = struct
  implicit module Int = Prelude.Semigroup.Additive.Int
  implicit module Float = Prelude.Semigroup.Additive.Float
end

module Multiplicative = struct
  implicit module Int = Prelude.Semigroup.Multiplicative.Int
  implicit module Float = Prelude.Semigroup.Multiplicative.Float
end
