open Sig
open Ty

module List = struct
  module Def = struct
    module T = Con.List.Poly
    let foldr f i xs = List.fold_right f xs i
    let foldl = List.fold_left
    let fold_map (type m) (module M : MONOID with type T.el = m) act =
      let rec go acc rest = match rest with
        | [] -> acc
        | (x::xs) -> go (M.op (act x) acc) xs in
      go M.unit
  end
  include Def
end
