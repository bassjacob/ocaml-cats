open Sig
open TyCon

module Cofree
  (FFun : FUNCTOR)
  (FTra : TRAVERSABLE with module T = FFun.T) =
struct
  module Data = Cofree.Make(FFun)
  include Functor.Cofree(FFun)
  include (Foldable.Cofree(FFun)(FTra) :
    module type of Foldable.Cofree(FFun)(FTra)
      with module T := T)

  let fork x xs = Data.Fork (x, xs)

  let traverse (type m) (m : m Sig.applicative) act =
    let module M = (val m) in
    let functor' = FTra.traverse m in
    let rec cofree (Data.Fork (x, xs)) = M.T.co @@
      M.apply
        (M.map fork (M.T.el (act x)))
        (M.T.el (functor' cofree xs)) in
    cofree
end

module List = struct
  include Functor.List
  include (Foldable.List : module type of Foldable.List
    with module T := T)

  let traverse (type m) (m : m applicative) act =
    let module M = (val m) in
    let rec go xs = match xs with
      | [] -> M.pure []
      | (x :: xs) -> M.apply (M.map Amb.cons (M.T.el (act x))) (go xs) in
    Amb.compose M.T.co go
end
