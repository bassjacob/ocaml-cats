open Sig
open TyCon

module Make (M : FOLDABLE) = struct open M
  let rec foldr (type b) (act : _ -> b -> b) init xs =
    let module B = TC0(struct type t = b end) in
    let module M = Def.Monoid.Endo(B) in
    fold_map (module M) act xs @@ init

  let rec foldl (type b) (act : b -> _ -> b) init xs =
    let module B = TC0(struct type t = b end) in
    let module M = Def.Monoid.Flip(Def.Monoid.Endo(B)) in
    fold_map (module M) (Amb.flip act) xs @@ init
end
