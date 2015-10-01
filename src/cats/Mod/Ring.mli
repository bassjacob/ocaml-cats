open Sig
open TyCon

module Unit : sig
  module Def = Def.Ring.Unit
  module Ext : sig
    include module type of Semiring.Unit.Ext
    include module type of Ext.Ring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Int : sig
  module Def = Def.Ring.Int
  module Ext : sig
    include module type of Semiring.Int.Ext
    include module type of Ext.Ring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Float : sig
  module Def = Def.Ring.Float
  module Ext : sig
    include module type of Semiring.Float.Ext
    include module type of Ext.Ring.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
