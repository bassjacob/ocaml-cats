open Sig
open Ty

module Option = struct
  module Def : FUNCTOR
    with module T = Con.Option.Poly =
  struct
    module T = Con.Option.Poly
    let map f = function
      | None -> None
      | Some x -> Some (f x)
  end
  include Def
  include Ext.Functor(Def)
end

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
