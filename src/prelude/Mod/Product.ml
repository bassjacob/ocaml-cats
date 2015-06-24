open Ambient
open Sig
open Ty

module Tuple = struct
  open Ambient
  module Def = struct
    include Bifunctor.Tuple.Def
    include Ambient.Product
  end
  include Def
end
