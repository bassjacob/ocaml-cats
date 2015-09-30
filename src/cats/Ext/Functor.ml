open Sig

module Make (M : FUNCTOR) = struct open M
  let (<$->) = map
  let (<-$>) x = Amb.flip (<$->) x
  let bang x = Amb.bang <$-> x
end
