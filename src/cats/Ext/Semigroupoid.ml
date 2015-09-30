open Sig

module Make (M : SEMIGROUPOID) = struct open M
  let (%>) = compose
  let (%<) f = Amb.flip compose f
end
