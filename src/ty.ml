type ('a, 'tc) ap

module Sig = struct
  module Nullary = struct
    module Invariant = struct
      module type ELEM = sig type el end
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
      module type ELEM = sig type +'a el end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Invariant = struct
      module type ELEM = sig type 'a el end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Contravariant = struct
      module type ELEM = sig type -'a el end
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
      module type ELEM = sig type (+'a, +'b) el end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module Invariant = struct
      module type ELEM = sig type ('a, 'b) el end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module ContraCovariant = struct
      module type ELEM = sig type (-'a, +'b) el end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end
  end
end

module Def = struct
  module Op = struct
    type tc
    external code : 'el -> 'tc = "%identity"
    external elem : 'tc -> 'el = "%identity"
  end

  module Nullary = struct
    open Sig.Nullary
    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE with type el = T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type el = T.el
      include Op
    end
  end

  module Unary = struct
    open Sig.Unary

    module Covariant
      : functor (T : Covariant.ELEM) -> Covariant.CODE with type +'a el = 'a T.el
      = functor (T : Covariant.ELEM) ->
    struct
      type +'a el = 'a T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE with type 'a el = 'a T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type 'a el = 'a T.el
      include Op
    end

    module Contravariant
      : functor (T : Contravariant.ELEM) -> Contravariant.CODE with type -'a el = 'a T.el
      = functor (T : Contravariant.ELEM) ->
    struct
      type -'a el = 'a T.el
      include Op
    end
  end

  module Binary = struct
    open Sig.Binary

    module Cov
      : functor (T : Covariant.ELEM) -> Covariant.CODE with type (+'a, +'b) el = ('a, 'b) T.el
      = functor (T : Covariant.ELEM) ->
    struct
      type (+'a, +'b) el = ('a, 'b) T.el
      include Op
    end

    module Invariant
      : functor (T : Invariant.ELEM) -> Invariant.CODE with type ('a, 'b) el = ('a, 'b) T.el
      = functor (T : Invariant.ELEM) ->
    struct
      type ('a, 'b) el = ('a, 'b) T.el
      include Op
    end

    module ContraCovariant
      : functor (T : ContraCovariant.ELEM) -> ContraCovariant.CODE with type (-'a, +'b) el = ('a, 'b) T.el
      = functor (T : ContraCovariant.ELEM) ->
    struct
      type (-'a, +'b) el = ('a, 'b) T.el
      include Op
    end
  end
end
