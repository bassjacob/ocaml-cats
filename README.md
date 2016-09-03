# ocaml-cats

Category theory for OCaml / Reason

### Examples

#### Miscellaneous

```rust
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

/* Semigroupoid for (=>) */
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
  let res = A.T.el res;
  assert (res == [[0, 1, 2, 3, 4]]);
};
```

#### Rose Trees

```rust
open Cats;
let module Rose: {
  let module Def: {
    include module type Def.Cofree.Make Def.Functor.List;
    include Sig.COMONAD with module T := T;
    include Sig.FOLDABLE with module T := T;
    include Sig.MONAD with module T := T;
    include Sig.TRAVERSABLE with module T := T;
  };
  include module type Def;
  include module type Ext.Apply.Make Def;
  include module type Ext.Bind.Make Def;
  include module type Ext.Comonad.Make Def;
  include module type Ext.Extend.Make Def;
  include module type Ext.Foldable.Make Def;
  include module type Ext.Functor.Make Def;
  include module type Ext.Monad.Make Def;
  include module type Ext.Traversable.Make Def;
} = {
  let module Def = {
    include Def.Cofree.Make Def.Functor.List;
    include (Def.Comonad.Cofree Def.Functor.List: Sig.COMONAD with module T := T);
    include (Def.Traversable.Cofree Def.Functor.List Def.Traversable.List: Sig.TRAVERSABLE with module T := T);
    let fork x xs => Fork x xs;
    let pure x => Fork x [];
    let rec bind (Fork x xs) k => switch (k x) {
      | Fork x' xs' => Fork x' (List.append xs' @@ List.map (fun x => bind x k) xs)
    };
    let apply mf mx =>
      bind mf @@ fun f =>
      bind mx @@ fun x =>
      pure @@ f x;
  };
  include Def;
  include Ext.Apply.Make Def;
  include Ext.Bind.Make Def;
  include Ext.Comonad.Make Def;
  include Ext.Extend.Make Def;
  include Ext.Foldable.Make Def;
  include Ext.Functor.Make Def;
  include Ext.Monad.Make Def;
  include Ext.Traversable.Make Def;
};
```

### Installing

The `cats` library is not yet available on the OPAM repository but you
can install it directly from this repository in the meantime with the
following:

* `opam pin add cats git://github.com/freebroccolo/ocaml-cats`

Once this completes, `cats` should be available as usual with
`ocamlfind`.

### Experimenting in `rtop`

Once `cats` is installed as above, you can load it up in `rtop`:

```
Reason # #require "cats";
Reason # open Cats.Mod;
Reason # Functor.List.map string_of_int [0, 1, 2];
- : list bytes = ["0", "1", "2"]
```

### Building

Pre-requisites:

* OCaml `4.02.3`
* Reason

The `cats` library can be built with `rebuild` using the build script:

* `./script/build`
