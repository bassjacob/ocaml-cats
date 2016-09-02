open Cats;
open Amb;
open Mod;
open Semigroupoid.Fun;
open TyCon;

/* Existentials for list functor */
let ex0 () => {
  let module E = Exists.Make Functor.List.T;
  let pkg = E.into [0, 1, 2, 3, 4]; /* pack */
  let res = E.from pkg { E.ap: List.length }; /* elim */
  assert (res == 5);
};

/* Bifunctor for tuple */
let ex1 () => {
  let res = Bifunctor.Tuple.bimap (fun x => x * 2) string_of_float (42, 3.14159);
  assert (res == (84, "3.14159"));
};

/* Semigroupoid for (->) */
let ex2 () => {
  let res = (fun x => x + 1) %> (fun x => x * 2) @@ 10;
  assert (res == 21);
};

/* Monoid for list */
let ex3 () => {
  let module M = Monoid.List (TC0 { type t = int; });
  let res = M.op [0, 1, 2, 3] [4, 5, 6, 7];
  assert (res == [0, 1, 2, 3, 4, 5, 6, 7]);
};

/* Foldable for list */
let ex4 () => {
  let module F = Foldable.List;
  let module Add = Monoid.Additive.Int;
  let module Mul = Monoid.Multiplicative.Int;
  let input = [1, 2, 3, 4, 5];
  let lhs = F.fold_map (module Add) id input;
  let rhs = F.fold_map (module Mul) id input;
  let res = Add.op lhs rhs;
  assert (res == 135);
};

/* Applicative for list */
let ex5 () => {
  let module A = Applicative.List;
  let res = A.apply [fun x => x * 2, fun x => x * 4, fun x => x * 8] [1, 2, 3];
  assert (res == [2, 4, 6, 4, 8, 12, 8, 16, 24]);
};

/* Traversable for list */
let ex6 () => {
  let module A = Applicative.List;
  let module T = Traversable.List;
  /* not very interesting but it works … */
  let res = T.traverse (module A) (A.T.co %> A.pure) [0, 1, 2, 3, 4];
  let res = A.T.el res; /* = [[0, 1, 2, 3, 4]] */
  assert (res == [[0, 1, 2, 3, 4]]);
};

/* Natural transformations */
let ex7 () => {
  open Functor;
  let module N = Transform.Make Option List;
  let res = { N.ap: fun x => switch x {
  | None => []
  | Some x => [x]
  } }.N.ap (Some 10);
  assert (res == [10]);
};

let () = {
  bang @@ ex0 ();
  bang @@ ex1 ();
  bang @@ ex2 ();
  bang @@ ex3 ();
  bang @@ ex4 ();
  bang @@ ex5 ();
  bang @@ ex6 ();
  bang @@ ex7 ();
};
