open Sig

module Make (M : SEMIRING) = struct open M
  let ( +@ ) = add
  let ( *@ ) = mul
end
