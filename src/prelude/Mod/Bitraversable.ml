open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    include Bifunctor.Tuple.Def
    include (Bifoldable.Tuple.Def : module type of Bifoldable.Tuple.Def
      with module T := T)

    let bitraverse (type m) (module A : APPLICATIVE with type T.co = m)
      : ('a -> ('c, m) ap) -> ('b -> ('d, m) ap) -> (('a, 'b) T.el -> (('c, 'd) T.el, m) ap)
      = fun f g p ->
        let module EFun = Ext.Functor.Make(A) in let open EFun in
        let module EApp = Ext.Apply  .Make(A) in let open EApp in
        let (%>) = Amb.compose in
        let res =
          pair
          <$-> (A.T.el %> f %> fst @@ p)
          <*>  (A.T.el %> g %> snd @@ p) in
        A.T.co res

    let bisequence m = bitraverse m Amb.id Amb.id

  end
  include Def
end
