open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  include Biapply.Tuple
  let bipure = pair
end
