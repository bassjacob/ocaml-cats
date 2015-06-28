open Ty.Sig

module Make (T : Unary.Covariant.CO) = struct
  module T = T
  type ('k, 'c) t =
    | L of 'k
    | N of 'c * ('k, 'c) t T.el
end
