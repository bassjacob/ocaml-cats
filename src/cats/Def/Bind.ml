open Sig

module Free (F : FUNCTOR) = struct
  include Functor.Free(F)
  include (Apply.Free(F) : APPLY with module T := T)
end

module Identity = struct
  include Apply.Identity
  let bind x f = f x
end
