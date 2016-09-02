open Sig;
open TyCon;

let module Make (M: BIFOLDABLE) => {
  open M;
  let bifoldr (type r) f g init xs => {
    let module R = TC0 {
      type t = r;
    };
    let module R = Def.Monoid.Endo R;
    bifold_map (module R) f g xs init
  };
  let bifoldl (type r) f g init xs => {
    let module R = TC0 {
      type t = r;
    };
    let module R = Def.Monoid.Flip (Def.Monoid.Endo R);
    bifold_map (module R) (Amb.flip f) (Amb.flip g) xs init
  };
  let biany p q => bifold_map (module Def.Monoid.Any) p q;
  let biall p q => bifold_map (module Def.Monoid.All) p q;
};
