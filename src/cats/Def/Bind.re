open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Data = Free.Make F;
  include Functor.Free F;
  include (Apply.Free F: APPLY with module T := T);
  let rec bind t k =>
    switch t {
    | Data.Leaf x => k x
    | Data.Fork xs => Data.Fork (F.map (fun x => bind x k) xs)
    };
};

let module Identity = {
  include Apply.Identity;
  let bind x f => f x;
};
