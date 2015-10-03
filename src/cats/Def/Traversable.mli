open Sig
open TyCon

module Cofree
  (FFun : FUNCTOR)
  (FTra : TRAVERSABLE with module T = FFun.T) :
sig
  include TRAVERSABLE with module T = Functor.Cofree(FFun).T
end

module List : sig
  include TRAVERSABLE with module T = Functor.List.T
end
