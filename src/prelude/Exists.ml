open Sig
open Ty.Sig

module Make (E : Unary.Invariant.CO) = struct
  module Def = struct
    module T = E
    type 'r elim = { ap : 'x. 'x T.el -> 'r }
    type t = Pack : 'x T.el -> t
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end
