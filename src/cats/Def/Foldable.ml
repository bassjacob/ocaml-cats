open Sig
open TyCon

module Cofree
    (F :
     sig
       include FOLDABLE
       include FUNCTOR with module T := T
     end) =
struct
  include Cofree.Make(F)

  let fold_map (type m) (m : m Sig.monoid) =
    let module M = (val m) in
    let functor' = F.fold_map m in
    let rec cofree act (Fork (x, xs)) =
      M.op (act x) (functor' (cofree act) xs) in
    cofree
end

module List = struct
  module T = TC.List

  let fold_map (type m) (m : m monoid) act =
    let module M = (val m) in
    let rec go acc rest = match rest with
      | [] -> acc
      | (x :: xs) -> go (M.op (act x) acc) xs in
    go M.unit
end

module Option = struct
  module T = TC.Option

  let fold_map (type m) (m : m monoid) act =
    let module M = (val m) in
    function
    | None -> M.unit
    | Some x -> M.op (act x) M.unit
end
