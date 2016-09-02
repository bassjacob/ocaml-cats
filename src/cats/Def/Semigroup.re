open Sig;
open TyCon;

let module Endo (A: TC0) => {
  let module T = TC0 {
    type t = A.el => A.el;
  };
  let op = Amb.compose;
};

let module Flip (M: SEMIGROUP) => {
  let module T = M.T;
  let op y x => M.op x y;
};

let module Any = {
  let module T = TC.Bool;
  let op = (||);
};

let module All = {
  let module T = TC.Bool;
  let op = (&&);
};

let module Unit = {
  let module T = TC.Unit;
  let op _ _ => ();
};

let module String = {
  let module T = TC.String;
  let op x y => String.concat "" [x, y];
};

let module Additive = {
  let module Int = {
    let module T = TC.Int;
    let op = (+);
  };
  let module Float = {
    let module T = TC.Float;
    let op = (+.);
  };
};

let module Multiplicative = {
  let module Int = {
    let module T = TC.Int;
    let op = ( * );
  };
  let module Float = {
    let module T = TC.Float;
    let op = ( *. );
  };
};

let module List (X: TC0) => {
  let module T = TC0 {
    type t = TC.List.el X.el;
  };
  let op = List.append;
};
