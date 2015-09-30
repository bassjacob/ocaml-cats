open Sig
open TyCon

module Diagonal (P : PROFUNCTOR) = TC1(struct
  type 'a t = ('a, 'a) P.T.el
end)

module Fun = struct
  module Def = struct
    module T = TC.Fun
    let dimap f g h = let (%>) = Amb.compose in g %> h %> f
  end
  include Def
  include Ext.Profunctor.Make(Def)
end
