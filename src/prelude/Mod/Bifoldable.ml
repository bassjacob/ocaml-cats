open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    module T = TC.Tuple
    let bifoldr f g i p =
      f (fst p) (g (snd p) i)
    let bifoldl f g i p =
      g (f i (fst p)) (snd p)
    let bifold_map (type m) (module M : MONOID with type T.el = m) f g p =
      M.op (f @@ fst p) (g @@ snd p)
  end
  include Def
end

module Variant = struct
  open Amb.Coproduct
  module Def = struct
    module T = TC.Variant
    let bifoldr f g i v = 
      from (fun x -> f x i) (fun y -> g y i) v
    let bifoldl f g i v =
      from (fun x -> f i x) (fun y -> g i y) v
    let bifold_map (type m) (module M : MONOID with type T.el = m) f g v =
      from f g v
  end
  include Def
end
