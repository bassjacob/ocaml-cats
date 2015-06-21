module List = struct
  module Def : Sig.TRAVERSABLE
    with module T = Functor.List.Def.T =
  struct
    open Semigroupoid.Fun
    include Functor.List.Def
    include (Foldable.List.Def : module type of Foldable.List.Def
             with module T := T)
    let traverse (type m) (module A : Sig.APPLICATIVE with type T.tc = m) f =
      let module EFun = Ext.Functor(A) in let open EFun in
      let module EApp = Ext.Apply  (A) in let open EApp in
      let rec go xs = match xs with
        | [] -> A.pure []
        | (x::xs) -> (fun h t -> h :: t) <$-> (A.T.elem %> f @@ x) <*> go xs in
      A.T.code %> go
    let sequence (type m) (module A : Sig.APPLICATIVE with type T.tc = m) =
      let module EFun = Ext.Functor(A) in let open EFun in
      let module EApp = Ext.Apply  (A) in let open EApp in
      let rec go xs = match xs with
        | [] -> A.pure []
        | (x::xs) -> (fun h t -> h :: t) <$-> (A.T.elem x) <*> go xs in
      A.T.code %> go
  end
  include Def
end
