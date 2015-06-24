open Sig

module Make (M : FUNCTOR) = struct open M
  let (<$->) = map
  let (<-$>) x = Ambient.flip (<$->) x
  let bang x = Ambient.bang <$-> x
end
