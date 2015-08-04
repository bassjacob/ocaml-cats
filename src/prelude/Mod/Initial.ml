open Sig

type t = { ex_falso : 'a. 'a }
let absurd { ex_falso } = ex_falso
