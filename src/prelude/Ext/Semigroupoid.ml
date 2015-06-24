open Sig

module Make (M : SEMIGROUPOID) = struct open M
  let (%>) = compose
  let (%<) f = Ambient.flip compose f
end
