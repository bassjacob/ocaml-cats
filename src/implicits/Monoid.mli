open Cats
open Cats.Sig
open Cats.TyCon

val unit : (implicit M : MONOID) -> M.T.el

implicit module Unit : module type of Mod.Monoid.Unit
implicit module String : module type of Mod.Monoid.String

module Additive : sig
  implicit module Int : module type of Mod.Monoid.Additive.Int
  implicit module Float : module type of Mod.Monoid.Additive.Float
end

module Multiplicative : sig
  implicit module Int : module type of Mod.Monoid.Multiplicative.Int
  implicit module Float : module type of Mod.Monoid.Multiplicative.Float
end
