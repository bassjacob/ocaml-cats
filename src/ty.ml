type ('a, 'tc) ap

module Sig = struct
  module Nullary = struct
    module Inv = struct
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
    module Cov = struct
      module type ELEM = sig type +'a el end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Inv = struct
      module type ELEM = sig type 'a el end
      module type CODE = sig
        include ELEM
        type tc
        external code : 'a el -> ('a, tc) ap = "%identity"
        external elem : ('a, tc) ap -> 'a el = "%identity"
      end
    end

    module Con = struct
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
    module Cov = struct
      module type ELEM = sig type (+'a, +'b) el end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module Inv = struct
      module type ELEM = sig type ('a, 'b) el end
      module type CODE = sig
        include ELEM
        type tc
        external code : ('a, 'b) el -> ('a, ('b, tc) ap) ap = "%identity"
        external elem : ('a, ('b, tc) ap) ap -> ('a, 'b) el = "%identity"
      end
    end

    module ConPro = struct
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
    module Inv
      : functor (T : Inv.ELEM) -> Inv.CODE with type el = T.el
      = functor (T : Inv.ELEM) ->
    struct
      type el = T.el
      include Op
    end
  end

  module Unary = struct
    open Sig.Unary

    module Cov
      : functor (T : Cov.ELEM) -> Cov.CODE with type +'a el = 'a T.el
      = functor (T : Cov.ELEM) ->
    struct
      type +'a el = 'a T.el
      include Op
    end

    module Inv
      : functor (T : Inv.ELEM) -> Inv.CODE with type 'a el = 'a T.el
      = functor (T : Inv.ELEM) ->
    struct
      type 'a el = 'a T.el
      include Op
    end

    module Con
      : functor (T : Con.ELEM) -> Con.CODE with type -'a el = 'a T.el
      = functor (T : Con.ELEM) ->
    struct
      type -'a el = 'a T.el
      include Op
    end
  end

  module Binary = struct
    open Sig.Binary

    module Cov
      : functor (T : Cov.ELEM) -> Cov.CODE with type (+'a, +'b) el = ('a, 'b) T.el
      = functor (T : Cov.ELEM) ->
    struct
      type (+'a, +'b) el = ('a, 'b) T.el
      include Op
    end

    module Inv
      : functor (T : Inv.ELEM) -> Inv.CODE with type ('a, 'b) el = ('a, 'b) T.el
      = functor (T : Inv.ELEM) ->
    struct
      type ('a, 'b) el = ('a, 'b) T.el
      include Op
    end

    module ConPro
      : functor (T : ConPro.ELEM) -> ConPro.CODE with type (-'a, +'b) el = ('a, 'b) T.el
      = functor (T : ConPro.ELEM) ->
    struct
      type (-'a, +'b) el = ('a, 'b) T.el
      include Op
    end
  end
end
