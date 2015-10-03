open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  include Applicative.Free(F)
  include (Bind.Free(F) : BIND with module T := T)
end

module Identity = struct
  include Applicative.Identity
  include (Bind.Identity : BIND with module T := T)
end
