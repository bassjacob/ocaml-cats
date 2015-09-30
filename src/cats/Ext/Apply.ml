open Sig

module Make (M : APPLY) = struct open M
  let (<*>) = apply
end
