# ocaml-prelude

A small OCaml prelude for algebraic and categorical concepts

Inspired by the Purescript prelude.

## API Reference

See [here](https://rawgit.com/freebroccolo/ocaml-prelude/master/docs/prelude/index.html)

### Examples

```ocaml
(* Existentials for list functor *)
let ex0 () : int = let module E = Exists(Functor.List) in
  let pkg = E.into [0; 1; 2; 3; 4] in (* pack *)
  E.from pkg { E.ap = List.length }   (* elim *)

(* Bifunctor for tuple *)
let ex1 () : int * string =
  Bifunctor.Tuple.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Semigroupoid for (->) *)
let ex2 () : int = let open Semigroupoid.Fn in
  (fun x -> x + 1) %> (fun x -> x * 2) @@ 10

(* Monoid for list *)
let ex3 () : int list =
  let module M = Monoid.List(struct type el = int end) in
  M.op [0;1;2;3] [4;5;6;7]

(* Foldable for list *)
let ex4 () : int =
  let module F = Foldable.List in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let input = [1; 2; 3; 4; 5] in
  let lhs = F.fold_map (module Add) Ambient.id input in
  let rhs = F.fold_map (module Mul) Ambient.id input in
    Add.op lhs rhs
```

### Building

Building the code requires the following:

* `opam`
* `ocaml`
* `oasis`

If you have `opam` installed you can fetch the other two:

1. # install opam with OS package manager, e.g., `brew install opam`
2. `opam switch install prelude -A 4.02.2` # (optional) switch to a new ocaml env
3. `opam install oasis`

Once the buildchain is installed you can generate a `Makefile`:

1. `opam pin add prelude . -n`
2. `oasis setup -setup-update dynamic`
3. `make`

### Experimenting

I recommend running the code with the excellent
[`utop`](https://github.com/diml/utop) toplevel:

1. # follow the build steps and run `make`
2. `utop -init .ocamlinit`

Once `utop` is loaded, definitions are available (with completion) per module:

```
utop # Prelude.ex4 ();;
- : int = 135
```