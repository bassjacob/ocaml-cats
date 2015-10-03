open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Data = Free.Make(F)
  include Functor.Free(F)
  include (Apply.Free(F) : APPLY with module T := T)
  let rec bind t k = match t with
    | Data.Leaf x -> k x
    | Data.Fork xs -> Data.Fork (F.map (fun x -> bind x k) xs)
end

module Identity = struct
  include Apply.Identity
  let bind x f = f x
end
