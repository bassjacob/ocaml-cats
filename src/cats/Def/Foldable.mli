open Sig
open TyCon

module List : sig
  include FOLDABLE with module T = TC.List
end

module Option : sig
  include FOLDABLE with module T = TC.Option
end
