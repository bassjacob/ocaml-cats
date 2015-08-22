open Sig

type t = { ex_falso : 'a. 'a }
let gnab { ex_falso } = ex_falso
