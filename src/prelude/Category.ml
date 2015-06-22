open Ambient
open Sig

module Fun = struct
  module Def = struct
    include Semigroupoid.Fun.Def
    let id = id
  end
  include Def
end
