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

module Op =
struct
  type co
  external co : 'a -> 'b =
    "%identity"
  external el : 'a -> 'b =
    "%identity"
end

module TC0 (T : sig type t end) =
struct
  type el = T.t
  include Op
end

module TC1 (T : sig type 'a t end) =
struct
  type 'a el = 'a T.t
  include Op
end

module TC2 (T : sig type ('a, 'b) t end) =
struct
  type ('a, 'b) el = ('a, 'b) T.t
  include Op
end

module TC3 (T : sig type ('a, 'b, 'c) t end) =
struct
  type ('a, 'b, 'c) el = ('a, 'b, 'c) T.t
  include Op
end

module TC4 (T : sig type ('a, 'b, 'c, 'd) t end) =
struct
  type ('a, 'b, 'c, 'd) s = ('a, 'b, 'c, 'd) T.t
  include Op
end

module TC5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) =
struct
  type ('a, 'b, 'c, 'd, 'e) s = ('a, 'b, 'c, 'd, 'e) T.t
  include Op
end

module TC6 (T : sig type ('a, 'b, 'c, 'd, 'e, 'f) t end) =
struct
  type ('a, 'b, 'c, 'd, 'e, 'f) s = ('a, 'b, 'c, 'd, 'e, 'f) T.t
  include Op
end

module TC =
struct
  module Float = TC0(struct type t = float end)
  module Fun = TC2(struct type ('a, 'b) t = 'a -> 'b end)
  module Identity = TC1(struct type 'a t = 'a end)
  module Int = TC0(struct type t = int end)
  module List = TC1(struct type 'a t = 'a list end)
  module Option = TC1(struct type 'a t = 'a option end)
  module String = TC0(struct type t = string end)
  module Tuple = TC2(struct type ('a, 'b) t = ('a, 'b) Amb.Product.t end)
  module Unit = TC0(struct type t = unit end)
  module Variant = TC2(struct type ('a, 'b) t = ('a, 'b) Amb.Coproduct.t end)
end
