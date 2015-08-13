open Sig

module Tuple = struct
  module Def = struct
    include Bifunctor.Tuple.Def
    include Amb.Product
  end
  include Def
end
