open Sig
open TyCon

module Make (Ran : RAN) = struct open Ran
  let map f { ran } = { ran = fun k -> ran (Amb.compose k f) }
end
