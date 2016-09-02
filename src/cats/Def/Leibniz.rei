open Sig;
open TyCon;

type t 'a 'b =
  | Refl: t 'a 'a;

include LEIBNIZ with type t 'a 'b := t 'a 'b;
