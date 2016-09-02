open Sig;
open TyCon;

let module Unit = {
  include Semiring.Unit;
  let div _ _ => ();
  let modulo _ _ => ();
};

let module Int = {
  include Semiring.Int;
  let div = (/);
  let modulo = (mod);
};

let module Float = {
  include Semiring.Float;
  let div = (/.);
  let modulo = mod_float;
};
