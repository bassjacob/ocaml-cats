open Sig
open TyCon

module Fun = struct
  include Semigroupoid.Fun
  let id = Amb.id
end
