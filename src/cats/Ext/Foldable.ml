open Sig
open TyCon

module Make (M : FOLDABLE) = struct open M
  let rec foldr (type m) f init xs =
    let module M = TC0(struct type t = m end) in
    let module M = Def.Monoid.Endo(M) in
    fold_map (module M) f xs @@ init

  let rec foldl (type m) f init xs =
    let module M = TC0(struct type t = m end) in
    let module M = Def.Monoid.Flip(Def.Monoid.Endo(M)) in
    fold_map (module M) (Amb.flip f) xs @@ init
end
