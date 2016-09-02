open Sig;
open TyCon;

let module Make (L: LEIBNIZ): {
  let cast: L.t 'a 'b => 'a => 'b;
};
