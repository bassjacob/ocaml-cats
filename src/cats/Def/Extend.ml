open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  module Data = Cofree.Make(F)
  include Functor.Cofree(F)
  let rec extend = fun t k -> match t with
    | Data.Fork (_, xs) -> Data.Fork (k t, F.map (fun x -> extend x k) xs)
end
