open Cats
open Cats.Sig

let unit (implicit M : MONOID) = M.unit

implicit module Unit = Mod.Monoid.Unit
implicit module String = Mod.Monoid.String

module Additive = struct
  implicit module Int = Mod.Monoid.Additive.Int
  implicit module Float = Mod.Monoid.Additive.Float
end

module Multiplicative = struct
  implicit module Int = Mod.Monoid.Multiplicative.Int
  implicit module Float = Mod.Monoid.Multiplicative.Float
end
