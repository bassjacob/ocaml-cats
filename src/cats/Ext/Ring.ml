open Sig

module Make (M : RING) = struct open M
  let (-@) = sub
  let negate x = zero -@ x
end
