open Sig
open TyCon

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
