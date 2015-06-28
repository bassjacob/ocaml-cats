open Sig

module Positive : sig
  module Def : sig
    include POSITIVE
    type ('k, 'c) p =
      | L of 'k
      | N of 'c * ('k, 'c) p
  end
  include (module type of Def)
  include (module type of Ext.Positive.Make(Def))
end
