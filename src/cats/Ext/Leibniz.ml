open Sig
open TyCon

module Make (L : LEIBNIZ) = struct open L
  let cast : ('a, 'b) L.t -> ('a -> 'b) = fun p x ->
    let module T = TC1(struct type 'x t = 'x end) in
    T.el @@ subst (module T) p @@ T.co x
end
