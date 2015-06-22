open Sig

module Make
  : functor (P : PROFUNCTOR) -> COEND
  = functor (P : PROFUNCTOR) ->
struct
  module Hom = P
  module Con = Exists.Make(Profunctor.Diagonal(Hom))
  module Def = Con.Def
  include Def
end
