open Sig
open TyCon

module Identity = struct
  include Apply.Identity

  let pure x = x
end

module Option = struct
  include Apply.Option

  let pure x = Some x
end

module List = struct
  include Apply.List

  let pure x = [x]
end
