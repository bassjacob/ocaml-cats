open Sig

module Make (P : PROFUNCTOR) = struct
  module Hom = P
  module Con = Forall.Make(Profunctor.Diagonal(Hom))
  module Def = Con.Def
  include Def
end
