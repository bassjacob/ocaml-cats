open Sig;
open TyCon;

let module Endo (A: TC0): {
  include MONOID with module T = Semigroup.Endo(A).T;
};

let module Flip (M: MONOID): {
  include MONOID with module T = Semigroup.Flip(M).T;
};

let module Any: {
  include MONOID with module T = Semigroup.Any.T;
};

let module All: {
  include MONOID with module T = Semigroup.All.T;
};

let module Unit: {
  include MONOID with module T = Semigroup.Unit.T;
};

let module String: {
  include MONOID with module T = Semigroup.String.T;
};

let module Additive: {
  let module Int: {
    include MONOID with module T = Semigroup.Additive.Int.T;
  };
  let module Float: {
    include MONOID with module T = Semigroup.Additive.Float.T;
  };
};

let module Multiplicative: {
  let module Int: {
    include MONOID with module T = Semigroup.Multiplicative.Int.T;
  };
  let module Float: {
    include MONOID with module T = Semigroup.Multiplicative.Float.T;
  };
};

let module List (A: TC0): {
  include MONOID with module T = Semigroup.List(A).T;
};
