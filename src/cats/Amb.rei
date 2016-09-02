let (@@): ('a => 'b) => ('a => 'b);
let (|>): 'a => (('a => 'r) => 'r);

let id: 'a => 'a;
let compose: ('b => 'c) => ('a => 'b) => ('a => 'c);
let cons: 'a => list 'a => list 'a;
let const: 'a => ('b => 'a);
let flip: ('a => 'b => 'c) => ('b => 'a => 'c);
let bang: 'a => unit;
let diagonal: 'a => ('a, 'a);
let curry: (('a, 'b) => 'c) => ('a => ('b => 'c));
let uncurry: ('a => ('b => 'c)) => (('a, 'b) => 'c);
let tap: ('a => unit) => ('a => 'a);

let module Initial: {
  type t;
  let abort: t => 'a;
};

let module Coproduct: {
  type t 'a 'b
    = Inl 'a
    | Inr 'b;
  let inl: 'a => t 'a 'b;
  let inr: 'b => t 'a 'b;
  let from: ('a => 'x) => ('b => 'x) => (t 'a 'b => 'x);
};

let module Product: {
  type t 'a 'b = ('a, 'b);
  let fst: t 'a 'b => 'a;
  let snd: t 'a 'b => 'b;
  let into: ('x => 'a) => ('x => 'b) => ('x => t 'a 'b);
  let pair: 'a => 'b => t 'a 'b;
};
