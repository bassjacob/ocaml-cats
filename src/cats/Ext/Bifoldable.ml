open Sig
open TyCon

module Make (M : BIFOLDABLE) = struct open M
  let bifoldr (type r) f g init xs =
    let module R = TC0(struct type t = r end) in
    let module R = Def.Monoid.Endo(R) in
    bifold_map (module R) f g xs init

  let bifoldl (type r) f g init xs =
    let module R = TC0(struct type t = r end) in
    let module R = Def.Monoid.Flip(Def.Monoid.Endo(R)) in
    bifold_map (module R) (Amb.flip f) (Amb.flip g) xs init
end
