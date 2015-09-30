open Sig

module Identity = struct
  module Def = struct
    include Applicative.Identity.Def
    include (Bind.Identity.Def : BIND with module T := T)
  end
  include Def
end
