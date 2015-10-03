open Sig
open TyCon

module Cofree
  (F :
   sig
     include FUNCTOR
     include TRAVERSABLE with module T := T
   end) =
struct
  include Functor.Cofree(F)
  include (Foldable.Cofree(F) : module type of Foldable.Cofree(F)
    with module T := T)

  let traverse (type m) (m : m Sig.applicative) act =
    let module M = (val m) in
    let functor' = F.traverse m in
    let rec cofree (Fork (x, xs)) = M.T.co @@
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
