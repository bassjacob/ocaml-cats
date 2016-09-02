open Sig;
open TyCon;

let module Unit = {
  include Semiring.Unit;
  let sub _ _ => ();
};

let module Int = {
  include Semiring.Int;
  let sub = (-);
};

let module Float = {
  include Semiring.Float;
  let sub = (-.);
};
