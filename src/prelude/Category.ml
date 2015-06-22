open Ambient
open Sig

module Fun = struct
  module Def : CATEGORY
    with module T = Semigroupoid.Fun.Def.T =
  struct
    include Semigroupoid.Fun.Def
    let id = id
  end
  include Def
end
