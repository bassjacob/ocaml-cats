# ocaml-prelude

A small OCaml prelude for algebraic and categorical concepts

Inspired by the Purescript prelude.

## API Reference

See [here](https://rawgit.com/freebroccolo/ocaml-prelude/master/docs/prelude/index.html)

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

1. `opam install oasis`
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