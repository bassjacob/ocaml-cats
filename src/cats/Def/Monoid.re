open Sig;
open TyCon;

let module Endo (A: TC0) => {
  include Semigroup.Endo A;
  let unit = Amb.id;
};

let module Flip (M: MONOID) => {
  include Semigroup.Flip M;
  let unit = M.unit;
};

let module Any = {
  include Semigroup.Any;
  let unit = false;
};

let module All = {
  include Semigroup.All;
  let unit = true;
};

let module Unit = {
  include Semigroup.Unit;
  let unit = ();
};

let module String = {
  include Semigroup.String;
  let unit = "";
};

let module Additive = {
  let module Int = {
    include Semigroup.Additive.Int;
    let unit = 0;
  };
  let module Float = {
    include Semigroup.Additive.Float;
    let unit = 0.0;
  };
};

let module Multiplicative = {
  let module Int = {
    include Semigroup.Multiplicative.Int;
    let unit = 1;
  };
  let module Float = {
    include Semigroup.Multiplicative.Float;
    let unit = 1.0;
  };
};

let module List (T: TC0) => {
  include Semigroup.List T;
  let unit = [];
};
