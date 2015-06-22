open Ambient
open Sig
open Ty
open Ty.Sig

module Join = functor (P : PROFUNCTOR) -> Ty.Make.Unary.Invariant(struct
  type 'a el = ('a, 'a) P.T.el
end)

module Fun = struct
  module Def : PROFUNCTOR
    with module T = Con.Fun.Poly =
  struct
    module T = Con.Fun.Poly
    let dimap f g h = let (%>) = compose in g %> h %> f
  end
  include Def
  include Ext.Profunctor(Def)
end
