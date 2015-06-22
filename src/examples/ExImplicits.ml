open Prelude
open Ambient

(* TODO: port full set of prelude examples to implicits style *)

open Implicits.Semigroup
open implicit Implicits.Semigroup

let ex0 () : bool =
  let p0 : bool = op "foo" "bar" = "foobar" in
  let p1 : bool = (let open implicit Additive in op 3 4) = 7 in
  let p2 : bool = (let open implicit Multiplicative in op 3 4) = 12 in
  p0 && p1 && p2

let () =
  Printf.printf "%B\n" (ex0 ())
