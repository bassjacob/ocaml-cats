open Sig
open Ty
open Ty.Sig

module Diagonal : functor (P : PROFUNCTOR) -> Unary.Invariant.CO
  with type 'a el = ('a, 'a) P.T.el

module Fun : sig
  module Def : PROFUNCTOR with module T = Con.Fun.Poly
  include (module type of Def)
  include (module type of Ext.Profunctor.Make(Def))
end
