open Prelude.Sig
open Prelude.Ty.Sig

val unit : (implicit M : MONOID) -> M.T.el

implicit module Unit : module type of Prelude.Monoid.Unit
implicit module String : module type of Prelude.Monoid.String

module Additive : sig
  implicit module Int : module type of Prelude.Monoid.Additive.Int
  implicit module Float : module type of Prelude.Monoid.Additive.Float
end

module Multiplicative : sig
  implicit module Int : module type of Prelude.Monoid.Multiplicative.Int
  implicit module Float : module type of Prelude.Monoid.Multiplicative.Float
end
