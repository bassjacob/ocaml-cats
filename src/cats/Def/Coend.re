open Sig;
open TyCon;

let module Make (P: PROFUNCTOR) => {
  let module Hom = P;
  include Exists.Make (Profunctor.Diagonal Hom);
};
