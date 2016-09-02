type ap 'f 'x;

module type TC0 = {
  type el;
  type co;
  external co: el => co = "%identity";
  external el: co => el = "%identity";
};

module type TC1 = {
  type el 'a;
  type co;
  external co: el 'a => ap co 'a = "%identity";
  external el: ap co 'a => el 'a = "%identity";
};

module type TC2 = {
  type el 'a 'b;
  type co;
  external co: el 'a 'b => ap (ap co 'a) 'b = "%identity";
  external el: ap (ap co 'a) 'b => el 'a 'b = "%identity";
};

module type TC3 = {
  type el 'a 'b 'c;
  type co;
  external co: el 'a 'b 'c => ap (ap (ap co 'a) 'b) 'c = "%identity";
  external el: ap (ap (ap co 'a) 'b) 'c => el 'a 'b 'c = "%identity";
};

module type TC4 = {
  type el 'a 'b 'c 'd;
  type co;
  external co: el 'a 'b 'c 'd => ap (ap (ap (ap co 'a) 'b) 'c) 'd = "%identity";
  external el: ap (ap (ap (ap co 'a) 'b) 'c) 'd => el 'a 'b 'c 'd = "%identity";
};

module type TC5 = {
  type el 'a 'b 'c 'd 'e;
  type co;
  external co: el 'a 'b 'c 'd 'e => ap (ap (ap (ap (ap co 'a) 'b) 'c) 'd) 'e = "%identity";
  external el: ap (ap (ap (ap (ap co 'a) 'b) 'c) 'd) 'e => el 'a 'b 'c 'd 'e = "%identity";
};

module type TC6 = {
  type el 'a 'b 'c 'd 'e 'f;
  type co;
  external co: el 'a 'b 'c 'd 'e 'f => ap (ap (ap (ap (ap (ap co 'a) 'b) 'c) 'd) 'e) 'f = "%identity";
  external el: ap (ap (ap (ap (ap (ap co 'a) 'b) 'c) 'd) 'e) 'f => el 'a 'b 'c 'd 'e 'f = "%identity";
};

let module Op: {
  type co;
  external co: 'a => 'b = "%identity";
  external el: 'a => 'b = "%identity";
};

let module TC0 (T: { type t; }): {
    type el = T.t;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC1 (T: { type t 'a; }): {
    type el 'a = T.t 'a;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC2 (T: { type t 'a 'b; }): {
    type el 'a 'b = T.t 'a 'b;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC3 (T: {type t 'a 'b 'c;}): {
    type el 'a 'b 'c = T.t 'a 'b 'c;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC4 (T: {type t 'a 'b 'c 'd;}): {
    type s 'a 'b 'c 'd = T.t 'a 'b 'c 'd;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC5 (T: {type t 'a 'b 'c 'd 'e;}): {
    type s 'a 'b 'c 'd 'e = T.t 'a 'b 'c 'd 'e;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC6 (T: {type t 'a 'b 'c 'd 'e 'f;}): {
    type s 'a 'b 'c 'd 'e 'f = T.t 'a 'b 'c 'd 'e 'f;
    type co = Op.co;
    external co: 'a => 'b = "%identity";
    external el: 'a => 'b = "%identity";
  };

let module TC: {
  let module Bool: TC0 with type el = bool;
  let module Float: TC0 with type el = float;
  let module Fun: TC2 with type el 'a 'b = 'a => 'b;
  let module Identity: TC1 with type el 'a = 'a;
  let module Int: TC0 with type el = int;
  let module List: TC1 with type el 'a = list 'a;
  let module Option: TC1 with type el 'a = option 'a;
  let module String: TC0 with type el = string;
  let module Tuple: TC2 with type el 'a 'b = Amb.Product.t 'a 'b;
  let module Unit: TC0 with type el = unit;
  let module Variant: TC2 with type el 'a 'b = Amb.Coproduct.t 'a 'b;
};

type tc0 'f = (module TC0 with type co ='f);
type tc1 'f = (module TC1 with type co ='f);
type tc2 'f = (module TC2 with type co ='f);
type tc3 'f = (module TC3 with type co ='f);
type tc4 'f = (module TC4 with type co ='f);
type tc5 'f = (module TC5 with type co ='f);
type tc6 'f = (module TC6 with type co ='f);
