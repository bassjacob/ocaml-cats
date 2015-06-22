type ('a, 'co) ap

module Sig = struct
  module Nullary = struct
    module Invariant = struct
      module type EL = sig
        type el
      end
      module type CO = sig
        include EL
        type co
        external co : el -> co = "%identity"
        external el : co -> el = "%identity"
      end
    end
  end

  module Unary = struct
    module Covariant = struct
      module type EL = sig
        type +'a el
      end
      module type CO = sig
        include EL
        type co
        external co : 'a el -> ('a, co) ap = "%identity"
        external el : ('a, co) ap -> 'a el = "%identity"
      end
    end

    module Invariant = struct
      module type EL = sig
        type 'a el
      end
      module type CO = sig
        include EL
        type co
        external co : 'a el -> ('a, co) ap = "%identity"
        external el : ('a, co) ap -> 'a el = "%identity"
      end
    end

    module Contravariant = struct
      module type EL = sig
        type -'a el
      end
      module type CO = sig
        include EL
        type co
        external co : 'a el -> ('a, co) ap = "%identity"
        external el : ('a, co) ap -> 'a el = "%identity"
      end
    end
  end

  module Binary = struct
    module Covariant = struct
      module type EL = sig
        type (+'a, +'b) el
      end
      module type CO = sig
        include EL
        type co
        external co : ('a, 'b) el -> ('a, ('b, co) ap) ap = "%identity"
        external el : ('a, ('b, co) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module Invariant = struct
      module type EL = sig
        type ('a, 'b) el
      end
      module type CO = sig
        include EL
        type co
        external co : ('a, 'b) el -> ('a, ('b, co) ap) ap = "%identity"
        external el : ('a, ('b, co) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module ContraCovariant = struct
      module type EL = sig
        type (-'a, +'b) el
      end
      module type CO = sig
        include EL
        type co
        external co : ('a, 'b) el -> ('a, ('b, co) ap) ap = "%identity"
        external el : ('a, ('b, co) ap) ap -> ('a, 'b) el = "%identity"
      end
    end
  end
end

module Make = struct
  module Op = struct
    type co
    external co : 'el -> 'co = "%identity"
    external el : 'co -> 'el = "%identity"
  end

  module Nullary = struct
    open Sig.Nullary
    module Invariant
      : functor (T : Invariant.EL) -> Invariant.CO
          with type el = T.el
      = functor (T : Invariant.EL) ->
    struct
      type el = T.el
      include Op
    end
  end

  module Unary = struct
    open Sig.Unary

    module Covariant
      : functor (T : Covariant.EL) -> Covariant.CO
          with type +'a el = 'a T.el
      = functor (T : Covariant.EL) ->
    struct
      type +'a el = 'a T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.EL) -> Invariant.CO
          with type 'a el = 'a T.el
      = functor (T : Invariant.EL) ->
    struct
      type 'a el = 'a T.el
      include Op
    end

    module Contravariant
      : functor (T : Contravariant.EL) -> Contravariant.CO
          with type -'a el = 'a T.el
      = functor (T : Contravariant.EL) ->
    struct
      type -'a el = 'a T.el
      include Op
    end
  end

  module Binary = struct
    open Sig.Binary

    module Covariant
      : functor (T : Covariant.EL) -> Covariant.CO
          with type (+'a, +'b) el = ('a, 'b) T.el
      = functor (T : Covariant.EL) ->
    struct
      type (+'a, +'b) el = ('a, 'b) T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.EL) -> Invariant.CO
          with type ('a, 'b) el = ('a, 'b) T.el
      = functor (T : Invariant.EL) ->
    struct
      type ('a, 'b) el = ('a, 'b) T.el
      include Op
    end

    module ContraCovariant
      : functor (T : ContraCovariant.EL) -> ContraCovariant.CO
          with type (-'a, +'b) el = ('a, 'b) T.el
      = functor (T : ContraCovariant.EL) ->
    struct
      type (-'a, +'b) el = ('a, 'b) T.el
      include Op
    end
  end
end

module Con : sig
  module Fun : sig
    module Poly : Sig.Binary.ContraCovariant.CO
      with type (-'a, +'b) el = 'a -> 'b
  end

  module Unit : Sig.Nullary.Invariant.CO
    with type el = unit

  module Int : Sig.Nullary.Invariant.CO
    with type el = int

  module Float : Sig.Nullary.Invariant.CO
    with type el = float

  module String : Sig.Nullary.Invariant.CO
    with type el = string

  module List : sig
    module Mono : functor (T : Sig.Nullary.Invariant.EL) -> Sig.Nullary.Invariant.CO
      with type el = T.el list
    module Poly : Sig.Unary.Covariant.CO
      with type +'a el = 'a list
  end

  module Tuple : sig
    module Poly : Sig.Binary.Covariant.CO
      with type (+'a, +'b) el = ('a, 'b) Ambient.Product.t
  end

  module Variant : sig
    module Poly : Sig.Binary.Covariant.CO
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
    module Mono = functor (T : Sig.Nullary.Invariant.EL) -> struct
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
