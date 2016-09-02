open Sig;
open TyCon;

let module Make (M: FOLDABLE) => {
  open M;
  let rec foldr (type r) f init xs => {
    let module R = TC0 { type t = r; };
    let module E = Def.Monoid.Endo R;
    fold_map (module E) f xs @@ init
  };
  let rec foldl (type r) f init xs => {
    let module R = TC0 { type t = r; };
    let module E = Def.Monoid.Flip (Def.Monoid.Endo R);
    fold_map (module E) (Amb.flip f) xs @@ init
  };
  let any p => fold_map (module Def.Monoid.Any) p;
  let all p => fold_map (module Def.Monoid.All) p;
  let elem x => any (fun y => x == y);
};
