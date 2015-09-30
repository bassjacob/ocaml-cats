open Sig

module Identity : sig
  module Def : BIND with module T = Functor.Identity.Def.T
  include (module type of Def)
end
