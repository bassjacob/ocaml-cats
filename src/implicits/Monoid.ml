open Prelude.Sig

let unit (implicit M : MONOID) = M.unit

implicit module Unit = Prelude.Monoid.Unit
implicit module String = Prelude.Monoid.String

module Additive = struct
  implicit module Int = Prelude.Monoid.Additive.Int
  implicit module Float = Prelude.Monoid.Additive.Float
end

module Multiplicative = struct
  implicit module Int = Prelude.Monoid.Multiplicative.Int
  implicit module Float = Prelude.Monoid.Multiplicative.Float
end
