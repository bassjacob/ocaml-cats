open Sig
open TyCon

module Tuple : sig
  module Def = Def.Bifoldable.Tuple
  module Ext : sig
    include module type of Ext.Bifoldable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end

module Variant : sig
  module Def = Def.Bifoldable.Variant
  module Ext : sig
    include module type of Ext.Bifoldable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
