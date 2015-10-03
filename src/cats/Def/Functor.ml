open Sig
open TyCon

module Cofree (F : FUNCTOR) = struct
  include Cofree.Make(F)
  let rec map f = function
    | Fork (x, xs) -> Fork (f x, F.map (map f) xs)
end

module Free (F : FUNCTOR) = struct
  include Free.Make(F)
  let rec map f = function
    | Leaf x -> Leaf (f x)
    | Fork xs -> Fork (F.map (map f) xs)
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
