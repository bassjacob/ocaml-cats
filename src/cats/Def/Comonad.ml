open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  module Data = Cofree.Make(F)
  include Extend.Cofree(F)
  let extract (Data.Fork (x, _)) = x
end
