open Sig
open TyCon

module Unit = struct
  include Semiring.Unit
  let sub _ _ = ()
end

module Int = struct
  include Semiring.Int
  let sub = (-)
end

module Float = struct
  include Semiring.Float
  let sub = (-.)
end
