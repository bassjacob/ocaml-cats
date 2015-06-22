open Sig
open Ty.Sig

module Make
  : functor (E : Unary.Invariant.CO) ->
sig
  module Def : UNIVERSAL
    with module T := E
  include (module type of Def)
end
  = functor (E : Unary.Invariant.CO) ->
struct
  module Def = struct
    module T = E
    type poly = { ap : 'x. 'x T. el }
    type t = poly
    external into : poly -> t = "%identity"
    external from : t -> poly = "%identity"
  end
  include Def
end
