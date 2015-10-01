open Sig

module Tuple : sig
  module Def = Def.Bitraversable.Tuple
  module Ext : sig
    include module type of Ext.Bitraversable.Make(Def)
  end
  include module type of Def
  include module type of Ext
end
