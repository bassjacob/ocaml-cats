open Sig;
open TyCon;

let module Unit = {
  include Ring.Unit;
  include (ModuloSemiring.Unit: MODULOSEMIRING with module T := T);
};

let module Float = {
  include Ring.Float;
  include (ModuloSemiring.Float: MODULOSEMIRING with module T := T);
};
