module Positive = struct
  module Def = struct
    exception InvalidDiv

    type code = B | O | I

    type ('k, 'c) p =
      | L of 'k
      | N of 'c * ('k, 'c) p

    type t = (unit, bool) p

    let head = function
      | L _ -> B
      | N (h, _) -> if h then I else O

    let one = L ()

    let mul2 x = N (false, x)

    let mul2s x = N (true, x)

    let div2 = function
      | N (false, x) -> x
      | _ -> raise InvalidDiv

    let div2p = function
      | N (true, x) -> x
      | _ -> raise InvalidDiv
  end
  include Def
  include Ext.Positive.Make(Def)
end
