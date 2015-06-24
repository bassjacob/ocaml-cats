open Sig

module Make (M : PROFUNCTOR) = struct open M
  let lmap f = dimap f Ambient.id
  let rmap f = dimap Ambient.id f
end
