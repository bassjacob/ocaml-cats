open Sig
open TyCon

module Identity = struct
  module Def = struct
    module T = TC.Identity
    let map f x = f x
  end
  include Def
  include Ext.Functor.Make(Def)
end

module Option = struct
  module Def = struct
    module T = TC.Option
    let map f = function
      | None -> None
      | Some x -> Some (f x)
  end
  include Def
  include Ext.Functor.Make(Def)
end

module List = struct
  module Def = struct
    module T = TC.List
    let map = List.map
  end
  include Def
  include Ext.Functor.Make(Def)
end
