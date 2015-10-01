open Sig
open TyCon

module Make (P : PROFUNCTOR) = struct
  module Hom = P
  include Forall.Make(Profunctor.Diagonal(Hom))
end
