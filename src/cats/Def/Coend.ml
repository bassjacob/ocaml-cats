open Sig
open TyCon

module Make (P : PROFUNCTOR) = struct
  module Hom = P
  include Exists.Make(Profunctor.Diagonal(Hom))
end
