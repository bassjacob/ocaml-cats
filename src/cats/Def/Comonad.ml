open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  include Extend.Cofree(F)
  let extract (Fork (x, _)) = x
end
