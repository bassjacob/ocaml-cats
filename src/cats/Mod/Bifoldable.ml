open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = Def.Bifoldable.Tuple
  module Ext = struct
    include Ext.Bifoldable.Make(Def)
  end
  include Def
  include Ext
end

module Variant = struct
  open Amb.Coproduct
  module Def = Def.Bifoldable.Variant
  module Ext = struct
    include Ext.Bifoldable.Make(Def)
  end
  include Def
  include Ext
end
