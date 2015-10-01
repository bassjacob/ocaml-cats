open Sig

module Identity = struct
  include Apply.Identity
  let bind x f = f x
end
