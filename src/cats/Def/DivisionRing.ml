open Sig
open TyCon

module Unit = struct
  include Ring.Unit
  include (ModuloSemiring.Unit : MODULOSEMIRING with module T := T)
end

module Float = struct
  include Ring.Float
  include (ModuloSemiring.Float : MODULOSEMIRING with module T := T)
end
