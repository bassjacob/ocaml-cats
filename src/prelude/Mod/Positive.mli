open Sig
open Ty.Sig

module Tree : NUMTREE

module Con : Nullary.CO

module Positive : sig
  module Def : POSITIVE with module T = Con
  include (module type of Def)
  include (module type of Ext.Positive.Make(Def))
end
