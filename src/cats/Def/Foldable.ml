open Sig
open TyCon

module List = struct
  module T = TC.List

  let foldr f z xs = List.fold_right f xs z

  let foldl = List.fold_left

  let fold_map (type m) (m : m monoid) act =
    let module M = (val m) in
    let rec go acc rest = match rest with
      | [] -> acc
      | (x :: xs) -> go (M.op (act x) acc) xs in
    go M.unit
end

module Option = struct
  module T = TC.Option

  let foldr f z xs = match xs with
    | None -> z
    | Some x -> f x z

  let foldl f a xs = match xs with
    | None -> a
    | Some x -> f a x

  let fold_map (type m) (m : m monoid) act =
    let module M = (val m) in
    function
    | None -> M.unit
    | Some x -> M.op (act x) M.unit
end
