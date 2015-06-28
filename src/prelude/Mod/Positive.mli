open Sig
open Ty

module Positive : sig
  module Def : sig
    include POSITIVE
  end with type t = (unit, bool) NumTree.Make(Con.Identity.Poly).t
  include (module type of Def)
  include (module type of Ext.Positive.Make(Def))
end
