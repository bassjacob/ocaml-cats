open Prelude.Sig

val unit : (implicit M : MONOID) -> M.T.el

implicit module Unit : MONOID with type T.el = unit

implicit module String : MONOID with type T.el = string

module Additive : sig
  implicit module Int : MONOID with type T.el = int
  implicit module Float : MONOID with type T.el = float
end

module Multiplicative : sig
  implicit module Int : MONOID with type T.el = int
  implicit module Float : MONOID with type T.el = float
end
