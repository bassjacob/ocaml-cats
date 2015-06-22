open Sig

module List = struct
  module Def = struct
    include Apply.List.Def
    let pure x = [x]
  end
  include Def
end
