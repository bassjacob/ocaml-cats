open Sig
open Ty.Sig.Unary

module Make : functor (J : Covariant.CO) (G : Covariant.CO) -> RAN
