open Sig
open TyCon

module Identity : sig
  include APPLY with module T = Functor.Identity.T
end

module Option : sig
  include APPLY with module T = Functor.Option.T
end

module List : sig
  include APPLY with module T = Functor.List.T
end
