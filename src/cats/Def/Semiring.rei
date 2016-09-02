open Sig;
open TyCon;

let module Unit: {
  include SEMIRING with module T = TC.Unit;
};

let module Int: {
  include SEMIRING with module T = TC.Int;
};

let module Float: {
  include SEMIRING with module T = TC.Float;
};
