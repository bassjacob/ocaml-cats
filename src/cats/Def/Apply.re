open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Data = Free.Make F;
  include Functor.Free F;
  let pure x => Data.Leaf x;
  let rec bind t k =>
    switch t {
    | Data.Leaf x => k x
    | Data.Fork xs => Data.Fork (F.map (fun x => bind x k) xs)
    };
  let apply mf mx =>
    bind mf @@ fun f =>
    bind mx @@ fun x =>
    pure @@ f x;
};

let module Identity = {
  include Functor.Identity;
  let rec apply f x => f x;
};

let module Option = {
  include Functor.Option;
  let rec apply: type b. option ('a => b) => (option 'a => option b) = fun fs xs => {
    switch fs {
    | None => None
    | Some f => map f xs
    };
  };
};

let module List = {
  include Functor.List;
  let rec apply: type b. list ('a => b) => (list 'a => list b) = fun fs xs => {
    let module M = Semigroup.List (TC0 { type t = b; });
    switch fs {
    | [] => []
    | [f, ...fs] => M.op (map f xs) (apply fs xs)
    }
  };
};
