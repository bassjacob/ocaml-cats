# ocaml-prelude

A small OCaml prelude for algebraic and categorical concepts

Inspired by the Purescript prelude.

### Examples

#### Standard OCaml

```ocaml
(* Bifunctor for tuple *)
let ex1 () : int * string =
  Bifunctor.Tuple.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Foldable for list *)
let ex4 () : int =
  let module F = Foldable.List in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let input = [1; 2; 3; 4; 5] in
  let lhs = F.fold_map (module Add) id input in
  let rhs = F.fold_map (module Mul) id input in
    Add.op lhs rhs

(* Applicative for list *)
let ex5 () : int list =
  let module A = Applicative.List in
  A.apply [(fun x -> x * 2); (fun x -> x * 4); (fun x -> x * 8)] [1; 2; 3]
```

#### Modular Implicits

Modular implicits provide implicit module resolution functionality based on
elaboration into first-class functors. They are similar to canonical structures
or modular type classes. Modular implicits support higher-rank, higher-kinded
polymorphism.

See the [paper](http://www.lpw25.net/ml2014.pdf) for further details.

```ocaml
(* Bifunctor for tuple, variant, etc. *)
let ex1 () : _ =
  let open implicit I.Bifunctor in
  let module M = I.Bifunctor in
  let _ = M.bimap (fun x -> x * 2) string_of_float (42, 3.14159) in
  let _ = M.bimap (fun x -> x ^ "bar") (fun y -> y +  1) (Coproduct.inl "foo") in
  let _ = M.bimap (fun x -> "foo" ^ x) (fun y -> y *. 2.0) (Coproduct.inr 1.0) in
  ()

(* Foldable for option, list, etc. *)
let ex4 () : _ =
  let open implicit I.Foldable in
  let module M = I.Foldable in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let _ = M.fold_map (module Add) id [1; 2; 3; 4; 5] in
  let _ = M.fold_map (module Mul) id [1; 2; 3; 4; 5] in
  let _ = M.fold_map (module Add) id None in
  let _ = M.fold_map (module Mul) id (Some 5) in
  ()

(* Applicative for option, list, etc. *)
let ex5 () : _ =
  let open implicit I.Applicative in
  let module M = I.Apply in
  let _ = M.apply (Some (fun x -> x ^ "bar")) (Some "foo") in
  let _ = M.apply [(fun x -> x * 2); (fun x -> x * 4); (fun x -> x * 8)] [1; 2; 3] in
  ()
```

##### Using modular implicits

The modular implicits functionality is available as a separate library
`implicits` that builds on the standard definitions in `prelude`. The
`implicits` library can be built with the [modular implicits
compiler](https://github.com/ocamllabs/ocaml-modular-implicits) which is also
available via `opam switch 4.02.1+modular-implicits-ber`.

### Installing

The `prelude` library is not yet available on the OPAM repository but you can
install it directly from this repository in the meantime with the following:

* `opam pin add prelude git://github.com/freebroccolo/ocaml-prelude`

Once this completes, `prelude` should be available as usual with `ocamlfind`.

### Experimenting in the toplevel

Once `prelude` is installed as above, you can load it up in the toplevel:

```
utop # #use "topfind";;
utop # #require "prelude";;
utop # Prelude.Functor.List.map string_of_int [0; 1; 2];;
- : bytes list = ["0"; "1"; "2"]
```

### Building

Building the code requires the following:

* `ocaml`

If you have `opam` you may optionally to switch to a new ocaml environment:

1. `opam switch install prelude -A 4.02.2` # (optional) switch to a new ocaml env
2. `opam pin add prelude .`

The `prelude` library can be built with `ocamlbuild` using the build script:

* `./script/build`

Additionally, the `implicits` library can be built using `./script/implicits` if
you have the appropriate compiler installed.