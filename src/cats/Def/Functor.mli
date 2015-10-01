open Sig
open TyCon

module Identity : sig
  include FUNCTOR with module T = TC.Identity
end

module Option : sig
  include FUNCTOR with module T = TC.Option
end

module List : sig
  include FUNCTOR with module T = TC.List
end
