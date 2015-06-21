type ('a, 'tc) ap

module Sig = struct
  module Nullary = struct
    module Invariant = struct
      module type ELEM = sig
        type el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : el -> tc = "%identity"
        external elem : tc -> el = "%identity"
      end
    end
  end

  module Unary = struct
    module Covariant = struct
      module type ELEM = sig
        type +'a el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Invariant = struct
      module type ELEM = sig
        type 'a el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Contravariant = struct
      module type ELEM = sig
        type -'a el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end
  end

  module Binary = struct
    module Covariant = struct
      module type ELEM = sig
        type (+'a, +'b) el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module Invariant = struct
      module type ELEM = sig
        type ('a, 'b) el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module ContraCovariant = struct
      module type ELEM = sig
        type (-'a, +'b) el
      end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end
  end
end

module Make = struct
  module Op = struct
    type tc
    external code : 'el -> 'tc = "%identity"
    external elem : 'tc -> 'el = "%identity"
  end

  module Nullary = struct
    open Sig.Nullary
    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE
          with type el = T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type el = T.el
      include Op
    end
  end

  module Unary = struct
    open Sig.Unary

    module Covariant
      : functor (T : Covariant.ELEM) -> Covariant.CODE
          with type +'a el = 'a T.el
      = functor (T : Covariant.ELEM) ->
    struct
      type +'a el = 'a T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE
          with type 'a el = 'a T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type 'a el = 'a T.el
      include Op
    end

    module Contravariant
      : functor (T : Contravariant.ELEM) -> Contravariant.CODE
          with type -'a el = 'a T.el
      = functor (T : Contravariant.ELEM) ->
    struct
      type -'a el = 'a T.el
      include Op
    end
  end

  module Binary = struct
    open Sig.Binary

    module Covariant
      : functor (T : Covariant.ELEM) -> Covariant.CODE
          with type (+'a, +'b) el = ('a, 'b) T.el
      = functor (T : Covariant.ELEM) ->
    struct
      type (+'a, +'b) el = ('a, 'b) T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE
          with type ('a, 'b) el = ('a, 'b) T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type ('a, 'b) el = ('a, 'b) T.el
      include Op
    end

    module ContraCovariant
      : functor (T : ContraCovariant.ELEM) -> ContraCovariant.CODE
          with type (-'a, +'b) el = ('a, 'b) T.el
      = functor (T : ContraCovariant.ELEM) ->
    struct
      type (-'a, +'b) el = ('a, 'b) T.el
      include Op
    end
  end
end

module Con : sig
  module Fun : sig
    module Poly : Sig.Binary.ContraCovariant.CODE
      with type (-'a, +'b) el = 'a -> 'b
  end

  module Unit : Sig.Nullary.Invariant.CODE
    with type el = unit

  module Int : Sig.Nullary.Invariant.CODE
    with type el = int

  module Float : Sig.Nullary.Invariant.CODE
    with type el = float

  module String : Sig.Nullary.Invariant.CODE
    with type el = string

  module List : sig
    module Mono : functor (T : Sig.Nullary.Invariant.ELEM) -> Sig.Nullary.Invariant.CODE
      with type el = T.el list
    module Poly : Sig.Unary.Covariant.CODE
      with type +'a el = 'a list
  end

  module Tuple : sig
    module Poly : Sig.Binary.Covariant.CODE
      with type (+'a, +'b) el = ('a, 'b) Ambient.Product.t
  end

  module Variant : sig
    module Poly : Sig.Binary.Covariant.CODE
      with type (+'a, +'b) el = ('a, 'b) Ambient.Coproduct.t
  end
end = struct
  module Fun = struct
    module Poly = Make.Binary.ContraCovariant(struct
      type (-'a, +'b) el = 'a -> 'b
    end)
  end

  module Unit =
    Make.Nullary.Invariant(struct type el = unit end)

  module Int =
    Make.Nullary.Invariant(struct type el = int end)

  module Float =
    Make.Nullary.Invariant(struct type el = float end)

  module String =
    Make.Nullary.Invariant(struct type el = string end)

  module List = struct
    module Mono = functor (T : Sig.Nullary.Invariant.ELEM) -> struct
      include Make.Nullary.Invariant(struct
        type el = T.el list
      end)
    end
    module Poly = Make.Unary.Covariant(struct
      type +'a el = 'a list
    end)
  end

  module Tuple = struct
    module Poly = Make.Binary.Covariant(struct
      type (+'a, +'b) el = ('a, 'b) Ambient.Product.t
    end)
  end

  module Variant = struct
    module Poly = Make.Binary.Covariant(struct
      type (+'a, +'b) el = ('a, 'b) Ambient.Coproduct.t
    end)
  end
end
