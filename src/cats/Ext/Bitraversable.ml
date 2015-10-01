open Sig
open TyCon

module Make (M : BITRAVERSABLE) = struct open M
  let bisequence m = bitraverse m Amb.id Amb.id
end
