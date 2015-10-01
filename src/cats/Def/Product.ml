open Sig
open TyCon

module Tuple = struct
  include Bifunctor.Tuple
  include Amb.Product
end
