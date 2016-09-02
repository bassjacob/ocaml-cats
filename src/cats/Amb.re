external (@@) : ('a => 'b) => 'a => 'b = "%apply";
external (|>) : 'a => ('a => 'r) => 'r = "%revapply";

external id : 'a => 'a = "%identity";
let compose g f x => g (f x);
let cons x xs => [x, ...xs];
let const x _ => x;
let flip f x y => f y x;
let bang x => const () x;
let diagonal x => (x, x);
let curry f x y => f (x, y);
let uncurry f (x, y) => f x y;
let tap f x => {
  f x;
  x;
};

let module Initial = {
  type t;
  let abort _ => failwith "Initial.abort";
};

let module Coproduct = {
  type t 'a 'b =
    | Inl 'a
    | Inr 'b;
  let inl a => Inl a;
  let inr b => Inr b;
  let from f g x =>
    switch x {
    | Inl a => f a
    | Inr b => g b
    };
};

let module Product = {
  type t 'a 'b = ('a, 'b);
  let fst (x, y) => x;
  let snd (x, y) => y;
  let into f g p => (f p, g p);
  let pair x y => into (const x) (const y) ();
};
