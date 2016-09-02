open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FTra: TRAVERSABLE with module T = FFun.T): {
  include TRAVERSABLE with module T = Functor.Cofree(FFun).T;
};

let module List: {
  include TRAVERSABLE with module T = Functor.List.T;
};
