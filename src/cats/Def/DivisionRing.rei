open Sig;
open TyCon;

let module Unit: {
  include DIVISIONRING with module T = Ring.Unit.T;
};

let module Float: {
  include Sig.DIVISIONRING with module T = Ring.Float.T;
};
