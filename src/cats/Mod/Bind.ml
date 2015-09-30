open Sig

module Identity = struct
  module Def = struct
    include Apply.Identity.Def
    let bind x f = f x
  end
  include Def
end
