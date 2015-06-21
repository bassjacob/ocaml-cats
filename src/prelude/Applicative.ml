module List = struct
  module Def : Sig.APPLICATIVE
    with module T = Functor.List.Def.T =
  struct
    include Apply.List.Def
    let pure x = [x]
  end
  include Def
end