open Sig
open TyCon

module Make (M : APPLY) = struct open M
  let (<*>) = apply
end
