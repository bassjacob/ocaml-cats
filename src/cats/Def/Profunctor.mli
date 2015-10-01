open Sig
open TyCon

module Diagonal : functor (P : PROFUNCTOR) -> TC1
  with type 'a el = ('a, 'a) P.T.el

module Fun : sig
  include PROFUNCTOR with module T = TC.Fun
end
