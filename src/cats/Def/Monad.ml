open Sig
open TyCon

module Identity = struct
  include Applicative.Identity
  include (Bind.Identity : BIND with module T := T)
end
