open Sig
open TyCon

module Make (M : SEMIRING) = struct open M
  let ( +@ ) = add
  let ( *@ ) = mul
end
