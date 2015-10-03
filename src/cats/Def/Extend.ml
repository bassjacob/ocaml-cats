open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  include Functor.Cofree(F)
  let rec extend = fun t k -> match t with
    | Fork (_, xs) -> Fork (k t, F.map (fun x -> extend x k) xs)
end
