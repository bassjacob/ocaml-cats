open Sig;
open TyCon;

let module Unit: {
  include RING with module T = Semiring.Unit.T;
};

let module Int: {
  include RING with module T = Semiring.Int.T;
};

let module Float: {
  include RING with module T = Semiring.Float.T;
};
