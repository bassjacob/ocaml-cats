open Sig
open Ty
open Ty.Sig

module Diagonal (P : PROFUNCTOR) = Make.Unary.Invariant(struct
  type 'a el = ('a, 'a) P.T.el
end)

module Fun = struct
  module Def = struct
    module T = Con.Fun.Poly
    let dimap f g h = let (%>) = Amb.compose in g %> h %> f
  end
  include Def
  include Ext.Profunctor.Make(Def)
end
