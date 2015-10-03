open Sig
open TyCon

module Cofree (F : FUNCTOR) : sig
  include FUNCTOR with module T = Cofree.Make(F).T
end

module Free (F : FUNCTOR) : sig
  include FUNCTOR with module T = Free.Make(F).T
end

module Identity : sig
  include FUNCTOR with module T = TC.Identity
end

module Option : sig
  include FUNCTOR with module T = TC.Option
end

module List : sig
  include FUNCTOR with module T = TC.List
end
