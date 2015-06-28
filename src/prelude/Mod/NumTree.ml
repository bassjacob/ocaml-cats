open Ty.Sig

module Make (F : Unary.Covariant.CO) = struct
  module F = F
  type ('k, 'c) t =
    | L of 'k
    | N of 'c * ('k, 'c) t F.el
end
