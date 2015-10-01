open Sig

module Make (M : COMONAD) = struct
  module E = Extend.Make(M);; open M;; open E
  let split mx = extend mx @@ fun x -> x
end
