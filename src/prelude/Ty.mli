type ('a, 'co) ap

module Sig : sig
  module Nullary : sig
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

  module Unary : sig
    module Covariant : sig
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

    module Invariant : sig
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

    module Contravariant : sig
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

  module Binary : sig
    module Covariant : sig
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

    module Invariant : sig
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

    module ContraCovariant : sig
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

module Make : sig
  module Op : sig
    type co
    external co : 'el -> 'co = "%identity"
    external el : 'co -> 'el = "%identity"
  end

  module Nullary : functor (T : Sig.Nullary.EL) -> Sig.Nullary.CO
    with type el = T.el

  module Unary : sig
    open Sig.Unary

    module Covariant : functor (T : Covariant.EL) -> Covariant.CO
      with type +'a el = 'a T.el

    module Invariant : functor (T : Invariant.EL) -> Invariant.CO
      with type 'a el = 'a T.el

    module Contravariant : functor (T : Contravariant.EL) -> Contravariant.CO
      with type -'a el = 'a T.el
  end

  module Binary : sig
    open Sig.Binary

    module Covariant : functor (T : Covariant.EL) -> Covariant.CO
      with type (+'a, +'b) el = ('a, 'b) T.el

    module Invariant : functor (T : Invariant.EL) -> Invariant.CO
      with type ('a, 'b) el = ('a, 'b) T.el

    module ContraCovariant : functor (T : ContraCovariant.EL) -> ContraCovariant.CO
      with type (-'a, +'b) el = ('a, 'b) T.el
  end
end

module Con : sig
  open Sig

  module Fun : sig
    module Poly : Binary.ContraCovariant.CO
      with type (-'a, +'b) el = 'a -> 'b
  end

  module Unit : Nullary.CO
    with type el = unit

  module Int : Nullary.CO
    with type el = int

  module Float : Nullary.CO
    with type el = float

  module String : Nullary.CO
    with type el = string

  module Identity : sig
    module Mono : functor (T : Nullary.EL) -> Nullary.CO
      with type el = T.el
    module Poly : Unary.Covariant.CO
      with type +'a el = 'a
  end

  module Option : sig
    module Mono : functor (T : Nullary.EL) -> Nullary.CO
      with type el = T.el option
    module Poly : Unary.Covariant.CO
      with type +'a el = 'a option
  end

  module List : sig
    module Mono : functor (T : Nullary.EL) -> Nullary.CO
      with type el = T.el list
    module Poly : Unary.Covariant.CO
      with type +'a el = 'a list
  end

  module Tuple : sig
    module Poly : Binary.Covariant.CO
      with type (+'a, +'b) el = ('a, 'b) Amb.Product.t
  end

  module Variant : sig
    module Poly : Binary.Covariant.CO
      with type (+'a, +'b) el = ('a, 'b) Amb.Coproduct.t
  end
end
