open Prelude
open Prelude.Sig

let compose (implicit M : SEMIGROUPOID) = M.compose

implicit module Fun = Mod.Semigroupoid.Fun

module Ext = struct
  let (%>) (implicit M : SEMIGROUPOID) = let module E = Ext.Semigroupoid.Make(M) in E.(%>)
  let (%<) (implicit M : SEMIGROUPOID) = let module E = Ext.Semigroupoid.Make(M) in E.(%<)
end
