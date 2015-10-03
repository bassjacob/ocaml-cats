open Sig
open TyCon

module Cofree (F : FUNCTOR) : sig
  include module type of Cofree.Make(F)
  include FUNCTOR with module T := T
  val fork : 'a -> 'a t F.T.el -> 'a t
end

module Free (F : FUNCTOR) : sig
  include module type of Free.Make(F)
  include FUNCTOR with module T := T
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
