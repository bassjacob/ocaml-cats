open Sig
open TyCon

module Fun = struct
  include Profunctor.Fun
  let compose = Amb.compose
end
