open Sig;
open TyCon;

let module Make (M: FUNCTOR) => {
  open M;
  let (<$->) = map;
  let (<-$>) x => Amb.flip (<$->) x;
  let bang x => Amb.bang <$-> x;
};
