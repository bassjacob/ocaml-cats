open Sig
open TyCon

module Free (F : FUNCTOR) = struct
  module Data = Free.Make(F)
  include Functor.Free(F)
  include (Apply.Free(F) : APPLY with module T := T)
  let pure x = Data.Leaf x
end

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
