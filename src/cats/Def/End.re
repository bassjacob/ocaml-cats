open Sig;
open TyCon;

let module Make (P: PROFUNCTOR) => {
  let module Hom = P;
  include Forall.Make (Profunctor.Diagonal Hom);
};
