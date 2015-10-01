open Sig

module Make (M : MONAD) = struct
  module E = Bind.Make(M);; open M;; open E
  let ap mf mx = mf >>= fun f -> mx >>= fun x -> pure (f x)
  let join mx = bind mx @@ fun x -> x
end
