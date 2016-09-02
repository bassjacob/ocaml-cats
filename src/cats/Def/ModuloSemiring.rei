open Sig;
open TyCon;

let module Unit: {
  include MODULOSEMIRING with module T = Semiring.Unit.T;
};

let module Int: {
  include MODULOSEMIRING with module T = Semiring.Int.T;
};

let module Float: {
  include MODULOSEMIRING with module T = Semiring.Float.T;
};
