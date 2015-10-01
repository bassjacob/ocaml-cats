open Sig
open TyCon

module Unit : sig
  include RING with module T = Semiring.Unit.T
end

module Int : sig
  include RING with module T = Semiring.Int.T
end

module Float : sig
  include RING with module T = Semiring.Float.T
end
