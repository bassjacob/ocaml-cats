open Sig;
open TyCon;

let module I = Initial;
let module L = Leibniz;

type t 'a 'b = L.t 'a 'b => I.t;

type obs 'a 'b =
  | Refl: obs 'a 'a
  | Void I.t: obs 'a 'b;

let into: type a b. L.t a b => obs a b = fun
  | L.Refl => Refl;

let from: type a b. obs a b => L.t a b = fun
  | Refl => L.Refl
  | Void i => I.gnab i;
