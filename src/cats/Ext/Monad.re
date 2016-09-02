open Sig;
open TyCon;

let module Make (M: MONAD) => {
  let module E = Bind.Make M;
  open M;
  open E;
  let ap mf mx =>
    mf >>= fun f =>
    mx >>= fun x =>
    pure (f x);
  let join mx =>
    mx >>= Amb.id;
};
