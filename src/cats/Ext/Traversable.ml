open Sig
open TyCon

module Make (M : TRAVERSABLE) = struct open M
  let sequence m = traverse m Amb.id
end
