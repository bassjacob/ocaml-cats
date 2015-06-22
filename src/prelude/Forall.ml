open Sig
open Ty.Sig

module Make (E : Unary.Invariant.CO) = struct
  module Def = struct
    module T = E
    type poly = { ap : 'x. 'x T. el }
    type t = poly
    external into : poly -> t = "%identity"
    external from : t -> poly = "%identity"
  end
  include Def
end
