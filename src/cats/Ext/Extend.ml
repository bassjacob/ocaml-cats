open Sig
open TyCon

module Make (M : EXTEND) = struct open M
  let (=>>) = extend
  let (=>=) g f x = g (extend x f)
end
