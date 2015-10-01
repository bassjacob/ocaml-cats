open Sig
open TyCon

module Make : functor (Ran : RAN) -> sig
  include FUNCTOR with module T := Ran.R
end
