open Sig
open TyCon

module Endo (A : TC0) = struct
  module T = TC0(struct type t = A.el -> A.el end)
  let op = Amb.compose
end

module Flip (M : SEMIGROUP) = struct
  module T = M.T
  let op y x = M.op x y
end

module Unit = struct
  module T = TC.Unit
  let op _ _ = ()
end

module String = struct
  module T = TC.String
  let op x y = String.concat "" [x; y]
end

module Additive = struct
  module Int = struct
    module T = TC.Int
    let op = (+)
  end

  module Float = struct
    module T = TC.Float
    let op = (+.)
  end
end

module Multiplicative = struct
  module Int = struct
    module T = TC.Int
    let op = ( * )
  end

  module Float = struct
    module T = TC.Float
    let op = ( *. )
  end
end

module List (X : TC0) = struct
  module T = TC0(struct type t = X.el TC.List.el end)
  let op = List.append
end
