open Cats
open Cats.Sig
open Cats.TyCon

val op : (implicit M : SEMIGROUP)
  -> M.T.el -> M.T.el -> M.T.el

implicit module Unit : module type Mod.Semigroup.Unit
implicit module String : module type Mod.Semigroup.String

module Additive : sig
  implicit module Int : module type Mod.Semigroup.Additive.Int
  implicit module Float : module type Mod.Semigroup.Additive.Float
end

module Multiplicative : sig
  implicit module Int : module type Mod.Semigroup.Multiplicative.Int
  implicit module Float : module type Mod.Semigroup.Multiplicative.Float
end
