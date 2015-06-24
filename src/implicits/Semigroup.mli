open Prelude
open Prelude.Sig
open Prelude.Ty.Sig

val op : (implicit M : SEMIGROUP)
  -> M.T.el -> M.T.el -> M.T.el

implicit module Unit : module type of Mod.Semigroup.Unit
implicit module String : module type of Mod.Semigroup.String

module Additive : sig
  implicit module Int : module type of Mod.Semigroup.Additive.Int
  implicit module Float : module type of Mod.Semigroup.Additive.Float
end

module Multiplicative : sig
  implicit module Int : module type of Mod.Semigroup.Multiplicative.Int
  implicit module Float : module type of Mod.Semigroup.Multiplicative.Float
end
