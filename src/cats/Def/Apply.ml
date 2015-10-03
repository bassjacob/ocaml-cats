open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Data = Free.Make(F)
  include Functor.Free(F)

  let pure x = Data.Leaf x

  let rec bind t k = match t with
    | Data.Leaf x -> k x
    | Data.Fork xs -> Data.Fork (F.map (fun x -> bind x k) xs)

  let apply mf mx =
    bind mf @@ fun f ->
    bind mx @@ fun x ->
    pure @@ f x
end

module Identity = struct
  include Functor.Identity
  let rec apply f x = f x
end

module Option = struct
  include Functor.Option

  let rec apply : type b. ('a -> b) option -> ('a option -> b option) = fun fs xs ->
    match fs with
    | None -> None
    | Some f -> map f xs
end

module List = struct
  include Functor.List

  let rec apply : type b. ('a -> b) list -> ('a list -> b list) = fun fs xs ->
    let module M = Semigroup.List(TC0(struct type t = b end)) in
    match fs with
    | [] -> []
    | (f :: fs) -> M.op (map f xs) (apply fs xs)
end
