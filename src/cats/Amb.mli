val (@@) : ('a -> 'b) -> ('a -> 'b)
val (|>) : 'a -> (('a -> 'r) -> 'r)

val id : 'a -> 'a
val compose : ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c)
val cons : 'a -> 'a list -> 'a list
val const : 'a -> ('b -> 'a)
val flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c)
val bang : 'a -> unit
val diagonal : 'a -> 'a * 'a
val curry : ('a * 'b -> 'c) -> ('a -> ('b -> 'c))
val uncurry : ('a -> ('b -> 'c)) -> ('a * 'b -> 'c)
val tap : ('a -> unit) -> ('a -> 'a)

module Initial : sig
  type t
  val abort : t -> 'a
end

module Coproduct : sig
  type ('a, 'b) t
    = Inl of 'a
    | Inr of 'b
  val inl : 'a -> ('a, 'b) t
  val inr : 'b -> ('a, 'b) t
  val from : ('a -> 'x) -> ('b -> 'x) -> (('a, 'b) t -> 'x)
end

module Product : sig
  type ('a, 'b) t = 'a * 'b
  val fst : ('a, 'b) t -> 'a
  val snd : ('a, 'b) t -> 'b
  val into : ('x -> 'a) -> ('x -> 'b) -> ('x -> ('a, 'b) t)
  val pair : 'a -> 'b -> ('a, 'b) t
end
