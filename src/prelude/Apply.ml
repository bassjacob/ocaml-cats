open Sig

module Option = struct
  module Def = struct
    include Functor.Option.Def
    let rec apply : type b. ('a -> b) option -> ('a option -> b option) = fun fs xs ->
      match fs with
      | None -> None
      | Some f -> map f xs
  end
  include Def
  include Ext.Apply(Def)
end

module List = struct
  module Def = struct
    include Functor.List.Def
    let rec apply : type b. ('a -> b) list -> ('a list -> b list) = fun fs xs ->
      let module M = Semigroup.List(struct type el = b end) in
      match fs with
      | [] -> []
      | (f::fs) -> M.op (map f xs) (apply fs xs)
  end
  include Def
  include Ext.Apply(Def)
end
