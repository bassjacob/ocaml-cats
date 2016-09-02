open Sig;
open TyCon;

let module Make (M: SEMIGROUPOID): {
  open M;
  let (%>): T.el 'b 'c => T.el 'a 'b => T.el 'a 'c;
  let (%<): T.el 'a 'b => T.el 'b 'c => T.el 'a 'c;
};
