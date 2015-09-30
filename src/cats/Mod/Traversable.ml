open Sig

module List = struct
  module Def = struct
    include Functor.List.Def
    include (Foldable.List.Def : module type of Foldable.List.Def
      with module T := T)

    let traverse (type m) (m : m applicative) f =
      let module A = (val m) in
      let rec go xs = match xs with
        | [] -> A.pure []
        | (x :: xs) -> A.apply (A.map Amb.cons (A.T.el @@ f @@ x)) (go xs) in
      fun x -> A.T.co @@ go @@ x

    let sequence m = traverse m Amb.id

  end
  include Def
end
