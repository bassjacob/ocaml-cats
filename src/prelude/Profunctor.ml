open Ambient
open Sig
open Ty
open Ty.Sig

module Join
    (* FIXME: is there a better name for this? *)
  : functor (P : PROFUNCTOR) -> Unary.Invariant.CO
  = functor (P : PROFUNCTOR) ->
struct
  include Ty.Make.Unary.Invariant(struct
    type 'a el = ('a, 'a) P.T.el
  end)
end

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
