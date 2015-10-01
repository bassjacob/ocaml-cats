open Sig
open TyCon

module List : sig
  include TRAVERSABLE with module T = Functor.List.T
end
