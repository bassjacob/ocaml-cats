open Sig;
open TyCon;

let module Endo (A: TC0): {
  let module Def: module type Def.Semigroup.Endo A;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module Flip (M: SEMIGROUP): {
  let module Def: module type Def.Semigroup.Flip M;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module Any: {
  let module Def = Def.Semigroup.Any;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module All: {
  let module Def = Def.Semigroup.All;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module Unit: {
  let module Def = Def.Semigroup.Unit;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module String: {
  let module Def = Def.Semigroup.String;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};

let module Additive: {
  let module Int: {
    let module Def = Def.Semigroup.Additive.Int;
    let module Ext: module type Ext.Semigroup.Make Def;
    include module type Def;
    include module type Ext;
  };
  let module Float: {
    let module Def = Def.Semigroup.Additive.Float;
    let module Ext: module type Ext.Semigroup.Make Def;
    include module type Def;
    include module type Ext;
  };
};

let module Multiplicative: {
  let module Int: {
    let module Def = Def.Semigroup.Multiplicative.Int;
    let module Ext: module type Ext.Semigroup.Make Def;
    include module type Def;
    include module type Ext;
  };
  let module Float: {
    let module Def = Def.Semigroup.Multiplicative.Float;
    let module Ext: module type Ext.Semigroup.Make Def;
    include module type Def;
    include module type Ext;
  };
};

let module List (A: TC0): {
  let module Def: module type Def.Semigroup.List A;
  let module Ext: module type Ext.Semigroup.Make Def;
  include module type Def;
  include module type Ext;
};