open Prelude.Sig
open Prelude.Ty.Sig

val op : (implicit M : SEMIGROUP)
  -> M.T.el -> M.T.el -> M.T.el

implicit module Unit : module type of Prelude.Semigroup.Unit
implicit module String : module type of Prelude.Semigroup.String

module Additive : sig
  implicit module Int : module type of Prelude.Semigroup.Additive.Int
  implicit module Float : module type of Prelude.Semigroup.Additive.Float
end

module Multiplicative : sig
  implicit module Int : module type of Prelude.Semigroup.Multiplicative.Int
  implicit module Float : module type of Prelude.Semigroup.Multiplicative.Float
end
