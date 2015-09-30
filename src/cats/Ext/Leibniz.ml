open Sig

module Make (L : LEIBNIZ) = struct
  open Ty.Make
  open Ty.Sig.Unary
  let cast : ('a, 'b) L.t -> ('a -> 'b) =
    let module Id = Unary.Invariant(struct type 'a el = 'a end) in
    L.subst (module Id : Invariant.CO with type T.co = Id.co)
end
