open Sig

module Make (M : MODULOSEMIRING) = struct open M
  let (/@) = div
  let (%@) = modulo
end
