open Sig
open Ty.Sig

module Make
  : functor (E : Unary.Invariant.CO) ->
sig
  module Def : EXISTENTIAL
    with module T := E
  include (module type of Def)
end
  = functor (E : Unary.Invariant.CO) ->
struct
  module Def = struct
    module T = E
    type t = Pack : 'x T.el -> t
    type 'r elim = { ap : 'x. 'x T.el -> 'r }
    let into x = Pack x
    let from p k = match p with Pack e -> k.ap e
  end
  include Def
end
