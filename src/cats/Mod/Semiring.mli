open Sig
open TyCon

module Unit : sig
  module Def = Def.Semiring.Unit
  module Ext : sig
    include module type of Ext.Semiring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Int : sig
  module Def = Def.Semiring.Int
  module Ext : sig
    include module type of Ext.Semiring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Float : sig
  module Def = Def.Semiring.Float
  module Ext : sig
    include module type of Ext.Semiring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
