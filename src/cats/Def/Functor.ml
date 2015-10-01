open Sig
open TyCon

module Identity = struct
  module T = TC.Identity
  let map f x = f x
end

module Option = struct
  module T = TC.Option
  let map f = function
    | None -> None
    | Some x -> Some (f x)
end

module List = struct
  module T = TC.List
  let map = List.map
end
