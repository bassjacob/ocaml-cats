open Sig;
open TyCon;

let module Fun = {
  include Profunctor.Fun;
  let compose = Amb.compose;
};
