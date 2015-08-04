module I = Initial
module L = Leibniz

type ('a, 'b) t = ('a, 'b) L.t -> I.t
type ('a, 'b) obs =
  | Refl : ('a, 'a) obs
  | Void : I.t -> ('a, 'b) obs

let into : type a b. (a, b) L.t -> (a, b) obs = function
  | L.Refl -> Refl

let from : type a b. (a, b) obs -> (a, b) L.t = function
  | Refl -> L.Refl
  | Void i -> I.absurd i
