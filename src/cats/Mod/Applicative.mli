open Sig
open TyCon

module Identity : sig
  module Def = Def.Applicative.Identity
  module Ext : sig
    include module type of Apply.Identity.Ext
  end
  include module type of Def
end

module Option : sig
  module Def = Def.Applicative.Option
  module Ext : sig
    include module type of Apply.Option.Ext
  end
  include module type of Def
end

module List : sig
  module Def = Def.Applicative.List
  module Ext : sig
    include module type of Apply.List.Ext
  end
  include module type of Def
end
