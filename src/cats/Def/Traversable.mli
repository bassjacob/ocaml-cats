open Sig
open TyCon

module Cofree (F : TRAVERSABLE) : sig
  include TRAVERSABLE with module T = Functor.Cofree(F).T
end

module List : sig
  include TRAVERSABLE with module T = Functor.List.T
end
