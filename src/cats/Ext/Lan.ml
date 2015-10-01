open Sig
open TyCon

module Make (Lan : LAN) = struct open Lan
  let map f (Lan (k, g)) = Lan (Amb.compose f k, g)
end
