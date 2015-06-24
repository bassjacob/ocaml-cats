open Sig
open Ty

module Option = struct
  module Def = struct
    module T = Con.Option.Poly
    let map f = function
      | None -> None
      | Some x -> Some (f x)
  end
  include Def
  include Ext.Functor.Make(Def)
end

module List = struct
  module Def = struct
    module T = Con.List.Poly
    let map = List.map
  end
  include Def
  include Ext.Functor.Make(Def)
end
