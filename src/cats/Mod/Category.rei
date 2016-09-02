open Sig;
open TyCon;

let module Fun: {
  let module Def = Def.Category.Fun;
  include module type Def;
};
