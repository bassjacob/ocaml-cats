open Prelude
open Prelude.Sig

let compose (implicit M : SEMIGROUPOID) = M.compose

implicit module Fun = Prelude.Semigroupoid.Fun

module Ext = struct
  let (%>) (implicit M : SEMIGROUPOID) = let module E = Ext.Semigroupoid(M) in E.(%>)
  let (%<) (implicit M : SEMIGROUPOID) = let module E = Ext.Semigroupoid(M) in E.(%<)
end
