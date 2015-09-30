open Cats
open Cats.Sig

let op (implicit M : SEMIGROUP) = M.op

implicit module Unit = Mod.Semigroup.Unit
implicit module String = Mod.Semigroup.String

module Additive = struct
  implicit module Int = Mod.Semigroup.Additive.Int
  implicit module Float = Mod.Semigroup.Additive.Float
end

module Multiplicative = struct
  implicit module Int = Mod.Semigroup.Multiplicative.Int
  implicit module Float = Mod.Semigroup.Multiplicative.Float
end
