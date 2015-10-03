open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  module Data = Cofree.Make(F)
  module T = Data.T
  let rec map f = function
    | Data.Fork (x, xs) -> Data.Fork (f x, F.map (map f) xs)
end

module Free (F : FUNCTOR) = struct
  module Data =  Free.Make(F)
  module T = Data.T
  let rec map f = function
    | Data.Leaf x -> Data.Leaf (f x)
    | Data.Fork xs -> Data.Fork (F.map (map f) xs)
end

module Identity = struct
  module T = TC.Identity
  let map f x = f x
end

module Option = struct
  module T = TC.Option
  let map f = function
    | None -> None
    | Some x -> Some (f x)
end

module List = struct
  module T = TC.List
  let map = List.map
end
