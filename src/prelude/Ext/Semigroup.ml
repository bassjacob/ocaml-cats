open Sig

module Make (M : SEMIGROUP) = struct open M
  let (@) = op
end
