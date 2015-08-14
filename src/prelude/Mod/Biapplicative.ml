open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    include Biapply.Tuple.Def
    let bipure = pair
  end
  include Def
end
