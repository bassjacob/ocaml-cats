open Sig;
open TyCon;

let module Endo (A: TC0): {
  include SEMIGROUP with type T.el = A.el => A.el;
};

let module Flip (M: SEMIGROUP): {
  include SEMIGROUP with module T = M.T;
};

let module Any: {
  include SEMIGROUP with module T = TC.Bool;
};

let module All: {
  include SEMIGROUP with module T = TC.Bool;
};

let module Unit: {
  include SEMIGROUP with module T = TC.Unit;
};

let module String: {
  include SEMIGROUP with module T = TC.String;
};

let module Additive: {
  let module Int: {
    include SEMIGROUP with module T = TC.Int;
  };
  let module Float: {
    include SEMIGROUP with module T = TC.Float;
  };
};

let module Multiplicative: {
  let module Int: {
    include SEMIGROUP with module T = TC.Int;
  };
  let module Float: {
    include SEMIGROUP with module T = TC.Float;
  };
};

let module List (X: TC0): {
  include SEMIGROUP with type T.el = TC.List.el X.el;
};
