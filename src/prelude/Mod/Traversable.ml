open Sig

module List = struct
  module Def = struct
    open Semigroupoid.Fun
    include Functor.List.Def
    include (Foldable.List.Def : module type of Foldable.List.Def
      with module T := T)

    let traverse (type m) (module A : APPLICATIVE with type T.co = m) f =
      let module EFun = Ext.Functor.Make(A) in let open EFun in
      let module EApp = Ext.Apply  .Make(A) in let open EApp in
      let act = A.T.el %> f in
      let rec go xs = match xs with
        | [] -> A.pure []
        | (x::xs) -> (fun h t -> h :: t) <$-> act x <*> go xs in
      A.T.co %> go

    let sequence m = traverse m Ambient.id

  end
  include Def
end
