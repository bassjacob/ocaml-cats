open Sig;
open TyCon;

let module Fun = {
  include Semigroupoid.Fun;
  let id = Amb.id;
};
