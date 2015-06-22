open Sig
open Ty

module List = struct
  module Def : FUNCTOR
    with module T = Con.List.Poly =
  struct
    module T = Con.List.Poly
    let map = List.map
  end
  include Def
  include Ext.Functor(Def)
end
