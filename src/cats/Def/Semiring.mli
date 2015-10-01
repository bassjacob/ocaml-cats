open Sig
open TyCon

module Unit : sig
  include SEMIRING with module T = TC.Unit
end

module Int : sig
  include SEMIRING with module T = TC.Int
end

module Float : sig
  include SEMIRING with module T = TC.Float
end
