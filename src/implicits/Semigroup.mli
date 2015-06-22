open Prelude.Sig

val op : (implicit M : SEMIGROUP) -> M.T.el -> M.T.el -> M.T.el

implicit module Unit : SEMIGROUP with type T.el = unit

implicit module String : SEMIGROUP with type T.el = string

module Additive : sig
  implicit module Int : SEMIGROUP with type T.el = int
  implicit module Float : SEMIGROUP with type T.el = float
end

module Multiplicative : sig
  implicit module Int : SEMIGROUP with type T.el = int
  implicit module Float : SEMIGROUP with type T.el = float
end
