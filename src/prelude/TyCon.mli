type ('p, 'f) ap

module type TC0 =
sig
  type el
  type co
  external co : el -> co = "%identity"
  external el : co -> el = "%identity"
end

module type TC1 =
sig
  type ('a) el
  type co
  external co : 'a el -> ('a, co) ap =
    "%identity"
  external el : ('a, co) ap -> 'a el =
    "%identity"
end

module type TC2 =
sig
  type ('a, 'b) el
  type co
  external co : ('a, 'b) el -> ('a, ('b, co) ap) ap =
    "%identity"
  external el : ('a, ('b, co) ap) ap -> ('a, 'b) el =
    "%identity"
end

module type TC3 =
sig
  type ('a, 'b, 'c) el
  type co
  external co : ('a, 'b, 'c) el -> ('a, ('b, ('c, co) ap) ap) ap =
    "%identity"
  external el : ('a, ('b, ('c, co) ap) ap) ap -> ('a, 'b, 'c) el =
    "%identity"
end

module type TC4 =
sig
  type ('a, 'b, 'c, 'd) el
  type co
  external co : ('a, 'b, 'c, 'd) el -> ('a, ('b, ('c, ('d, co) ap) ap) ap) ap =
    "%identity"
  external el : ('a, ('b, ('c, ('d, co) ap) ap) ap) ap -> ('a, 'b, 'c, 'd) el =
    "%identity"
end

module type TC5 =
sig
  type ('a, 'b, 'c, 'd, 'e) el
  type co
  external co : ('a, 'b, 'c, 'd, 'e) el -> ('a, ('b, ('c, ('d, ('e, co) ap) ap) ap) ap) ap =
    "%identity"
  external el : ('a, ('b, ('c, ('d, ('e, co) ap) ap) ap) ap) ap -> ('a, 'b, 'c, 'd, 'e) el =
    "%identity"
end

module type TC6 =
sig
  type ('a, 'b, 'c, 'd, 'e, 'f) el
  type co
  external co : ('a, 'b, 'c, 'd, 'e, 'f) el -> ('a, ('b, ('c, ('d, ('e, ('f, co) ap) ap) ap) ap) ap) ap =
    "%identity"
  external el : ('a, ('b, ('c, ('d, ('e, ('f, co) ap) ap) ap) ap) ap) ap -> ('a, 'b, 'c, 'd, 'e, 'f) el =
    "%identity"
end

module Op :
sig
  type co
  external co : 'a -> 'b =
    "%identity"
  external el : 'a -> 'b =
    "%identity"
end

module TC0 :
  functor (T : sig type t end) ->
  sig
    type el = T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC1 :
  functor (T : sig type 'a t end) ->
  sig
    type 'a el = 'a T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC2 :
  functor (T : sig type ('a, 'b) t end) ->
  sig
    type ('a, 'b) el = ('a, 'b) T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC3 :
  functor (T : sig type ('a, 'b, 'c) t end) ->
  sig
    type ('a, 'b, 'c) el = ('a, 'b, 'c) T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC4 :
  functor (T : sig type ('a, 'b, 'c, 'd) t end) ->
  sig
    type ('a, 'b, 'c, 'd) s = ('a, 'b, 'c, 'd) T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC5 :
  functor (T : sig type ('a, 'b, 'c, 'd, 'e) t end) ->
  sig
    type ('a, 'b, 'c, 'd, 'e) s = ('a, 'b, 'c, 'd, 'e) T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC6 :
  functor (T : sig type ('a, 'b, 'c, 'd, 'e, 'f) t end) ->
  sig
    type ('a, 'b, 'c, 'd, 'e, 'f) s = ('a, 'b, 'c, 'd, 'e, 'f) T.t
    type co = Op.co
    external co : 'a -> 'b =
      "%identity"
    external el : 'a -> 'b =
      "%identity"
  end

module TC :
sig
  module Float : TC0 with type el = float
  module Fun : TC2 with type ('a, 'b) el = 'a -> 'b
  module Identity : TC1 with type 'a el = 'a
  module Int : TC0 with type el = int
  module List : TC1 with type 'a el = 'a list
  module Option : TC1 with type 'a el = 'a option
  module String : TC0 with type el = string
  module Tuple : TC2 with type ('a, 'b) el = ('a, 'b) Amb.Product.t
  module Unit : TC0 with type el = unit
  module Variant : TC2 with type ('a, 'b) el = ('a, 'b) Amb.Coproduct.t
end
