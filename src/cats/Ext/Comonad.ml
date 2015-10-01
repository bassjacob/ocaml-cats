open Sig
open TyCon

module Make (M : COMONAD) = struct
  module E = Extend.Make(M);; open M;; open E
  let split mx = mx =>> Amb.id
end
