open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Data = Free.Make F;
  include Functor.Free F;
  include (Apply.Free F: APPLY with module T := T);
  let pure x => Data.Leaf x;
};

let module Identity = {
  include Apply.Identity;
  let pure x => x;
};

let module Option = {
  include Apply.Option;
  let pure x => Some x;
};

let module List = {
  include Apply.List;
  let pure x => [x];
};
