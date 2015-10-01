open Sig
open TyCon

module Unit = struct
  include Semiring.Unit

  let div _ _ = ()
  let modulo _ _ = ()
end

module Int = struct
  include Semiring.Int

  let div = (/)
  let modulo = (mod)
end

module Float = struct
  include Semiring.Float

  let div = (/.)
  let modulo = mod_float
end
