open Sig
open TyCon

module Cofree
  (FFun : FUNCTOR)
  (FFol : FOLDABLE with module T = FFun.T) :
sig
  include FOLDABLE with module T = Cofree.Make(FFun).T
end

module List : sig
  include FOLDABLE with module T = TC.List
end

module Option : sig
  include FOLDABLE with module T = TC.Option
end
