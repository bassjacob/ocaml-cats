open Sig
open TyCon

module Make (M : FOLDABLE) = struct open M
  let rec foldr (type r) f init xs =
    let module R = TC0(struct type t = r end) in
    let module E = Def.Monoid.Endo(R) in
    fold_map (module E) f xs @@ init

  let rec foldl (type r) f init xs =
    let module R = TC0(struct type t = r end) in
    let module E = Def.Monoid.Flip(Def.Monoid.Endo(R)) in
    fold_map (module E) (Amb.flip f) xs @@ init
end
