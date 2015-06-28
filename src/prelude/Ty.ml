type ('a, 'co) ap

module Sig = struct
  module Nullary = struct
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

  module Nullary (T : Sig.Nullary.EL) = struct
    type el = T.el
    include Op
  end

  module Unary = struct
    open Sig.Unary

    module Covariant (T : Covariant.EL) = struct
      type +'a el = 'a T.el
      include Op
    end

    module Invariant (T : Invariant.EL) = struct
      type 'a el = 'a T.el
      include Op
    end

    module Contravariant (T : Contravariant.EL) = struct
      type -'a el = 'a T.el
      include Op
    end
  end

  module Binary = struct
    open Sig.Binary

    module Covariant (T : Covariant.EL) = struct
      type (+'a, +'b) el = ('a, 'b) T.el
      include Op
    end

    module Invariant (T : Invariant.EL) = struct
      type ('a, 'b) el = ('a, 'b) T.el
      include Op
    end

    module ContraCovariant (T : ContraCovariant.EL) = struct
      type (-'a, +'b) el = ('a, 'b) T.el
      include Op
    end
  end
end

module Con = struct
  open Sig

  module Fun = struct
    module Poly = Make.Binary.ContraCovariant(struct
      type (-'a, +'b) el = 'a -> 'b
    end)
  end

  module Unit = Make.Nullary(struct
    type el = unit
  end)

  module Int = Make.Nullary(struct
    type el = int
  end)

  module Float = Make.Nullary(struct
    type el = float
  end)

  module String = Make.Nullary(struct
    type el = string
  end)

  module Identity = struct
    module Mono (T : Nullary.EL) = struct
      include Make.Nullary(struct
        type el = T.el
      end)
    end
    module Poly = Make.Unary.Covariant(struct
      type +'a el = 'a
    end)
  end

  module Option = struct
    module Mono (T : Nullary.EL) = struct
      include Make.Nullary(struct
        type el = T.el option
      end)
    end
    module Poly = Make.Unary.Covariant(struct
      type +'a el = 'a option
    end)
  end

  module List = struct
    module Mono (T : Nullary.EL) = struct
      include Make.Nullary(struct
        type el = T.el list
      end)
    end
    module Poly = Make.Unary.Covariant(struct
      type +'a el = 'a list
    end)
  end

  module Tuple = struct
    module Poly = Make.Binary.Covariant(struct
      type (+'a, +'b) el = ('a, 'b) Amb.Product.t
    end)
  end

  module Variant = struct
    module Poly = Make.Binary.Covariant(struct
      type (+'a, +'b) el = ('a, 'b) Amb.Coproduct.t
    end)
  end
end
