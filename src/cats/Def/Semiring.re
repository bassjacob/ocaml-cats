open Sig;
open TyCon;

let module Unit = {
  let module T = TC.Unit;
  let zero = ();
  let add _ _ => ();
  let one = ();
  let mul _ _ => ();
};

let module Int = {
  let module Add = Monoid.Additive.Int;
  let module Mul = Monoid.Multiplicative.Int;
  let module T = TC.Int;
  let zero = Add.unit;
  let add = Add.op;
  let one = Mul.unit;
  let mul = Mul.op;
};

let module Float = {
  let module Add = Monoid.Additive.Float;
  let module Mul = Monoid.Multiplicative.Float;
  let module T = TC.Float;
  let zero = Add.unit;
  let add = Add.op;
  let one = Mul.unit;
  let mul = Mul.op;
};
