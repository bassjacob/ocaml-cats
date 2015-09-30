open Sig

module Fun = struct
  module Def = struct
    include Semigroupoid.Fun.Def
    let id = Amb.id
  end
  include Def
end
