open Sig

module Make (M : PROFUNCTOR) = struct open M
  let lmap f = dimap f Amb.id
  let rmap f = dimap Amb.id f
end
