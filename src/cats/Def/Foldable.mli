open Sig
open TyCon

module Cofree
  (F :
   sig
     include FOLDABLE
     include FUNCTOR with module T := T
   end) :
sig
  include FOLDABLE with module T = Cofree.Make(F).T
end

module List : sig
  include FOLDABLE with module T = TC.List
end

module Option : sig
  include FOLDABLE with module T = TC.Option
end
