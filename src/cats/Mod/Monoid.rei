open Sig;
open TyCon;

let module Endo (A: TC0): {
  let module Def: module type Def.Monoid.Endo(A);
  let module Ext: {
    /* include module type Semigroup.Endo(A).Ext */
  };
  include module type Def;
  include module type Ext;
};

let module Flip (M: MONOID): {
  let module Def: MONOID with module T = Def.Monoid.Flip(M).T;
  let module Ext: {
    /* include Semigroup.Flip(M).Ext */
  };
  include module type Def;
  include module type Ext;
};

let module Any: {
  let module Def: MONOID with module T = Def.Monoid.Any.T;
  let module Ext: {
    include module type Semigroup.Any.Ext;
  };
  include module type Def;
  include module type Ext;
};

let module All: {
  let module Def: MONOID with module T = Def.Monoid.All.T;
  let module Ext: {
    include module type Semigroup.All.Ext;
  };
  include module type Def;
  include module type Ext;
};

let module Unit: {
  let module Def: MONOID with module T = Def.Monoid.Unit.T;
  let module Ext: {
    include module type Semigroup.Unit.Ext;
  };
  include module type Def;
  include module type Ext;
};

let module String: {
  let module Def: MONOID with module T = Def.Monoid.String.T;
  let module Ext: {
    include module type Semigroup.String.Ext;
  };
  include module type Def;
  include module type Ext;
};

let module Additive: {
  let module Int: {
    let module Def: MONOID with module T = Def.Monoid.Additive.Int.T;
    let module Ext: {
      include module type Semigroup.Additive.Int.Ext;
    };
    include module type Def;
    include module type Ext;
  };

  let module Float: {
    let module Def: MONOID with module T = Def.Monoid.Additive.Float.T;
    let module Ext: {
      include module type Semigroup.Additive.Float.Ext;
    };
    include module type Def;
    include module type Ext;
  };
};

let module Multiplicative: {
  let module Int: {
    let module Def: MONOID with module T = Def.Monoid.Multiplicative.Int.T;
    let module Ext: {
      include module type Semigroup.Multiplicative.Int.Ext;
    };
    include module type Def;
    include module type Ext;
  };

  let module Float: {
    let module Def: MONOID with module T = Def.Monoid.Multiplicative.Float.T;
    let module Ext: {
      include module type Semigroup.Multiplicative.Float.Ext;
    };
    include module type Def;
    include module type Ext;
  };
};

let module List (A: TC0): {
  let module Def: MONOID with module T = Def.Monoid.List(A).T;
  let module Ext: {
    /* include module type Semigroup.List.Ext */
  };
  include module type Def;
  include module type Ext;
};
