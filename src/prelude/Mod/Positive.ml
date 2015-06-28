open Ty

module Positive = struct
  module Def = struct
    exception InvalidDiv

    type code = B | O | I

    module Tree = NumTree.Make(Con.Identity.Poly)

    type t = (unit, bool) Tree.t

    let head = function
      | Tree.L _ -> B
      | Tree.N (h, _) -> if h then I else O

    let one = Tree.L ()

    let mul2 x = Tree.N (false, x)

    let mul2s x = Tree.N (true, x)

    let div2 = function
      | Tree.N (false, x) -> x
      | _ -> raise InvalidDiv

    let div2p = function
      | Tree.N (true, x) -> x
      | _ -> raise InvalidDiv
  end
  include Def
  include Ext.Positive.Make(Def)
end
