module List = struct
  module Def : Sig.APPLY
    with module T = Functor.List.Def.T =
  struct
    include Functor.List.Def
    let rec apply : type b. ('a -> b) list -> ('a list -> b list) = fun fs xs ->
      let module S = Semigroup.List(struct type el = b end) in
      match fs with
      | [] -> []
      | (f::fs) -> S.op (map f xs) (apply fs xs)
  end
  include Def
  include Ext.Apply(Def)
end
