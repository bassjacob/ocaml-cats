open Sig;
open TyCon;

let module I = Initial;
let module L = Leibniz;

type obs 'a 'b =
  | Refl: obs 'a 'a
  | Void I.t: obs 'a 'b;

include APART with module I := I and module L := L;

let into: L.t 'a 'b => obs 'a 'b;
let from: obs 'a 'b => L.t 'a 'b;
