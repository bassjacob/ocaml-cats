open Sig
open TyCon

module Make (M : SEMIGROUP) = struct open M
  let (@) = op
end
