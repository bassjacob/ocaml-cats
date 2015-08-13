open Sig
open TyCon

module Diagonal : functor (P : PROFUNCTOR) -> TC1
  with type 'a el = ('a, 'a) P.T.el

module Fun : sig
  module Def : PROFUNCTOR with module T = TC.Fun
  include (module type of Def)
  include (module type of Ext.Profunctor.Make(Def))
end
