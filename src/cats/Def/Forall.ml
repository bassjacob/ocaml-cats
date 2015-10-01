open Sig
open TyCon

module Make (E : TC1) = struct
  module T = E

  type poly = { ap : 'x. 'x T. el }
  type t = poly

  external into : poly -> t = "%identity"
  external from : t -> poly = "%identity"
end
