open Sig;
open TyCon;

let module Make (L: LEIBNIZ) => {
  open L;
  let cast: L.t 'a 'b => 'a => 'b =
    fun p x => {
      let module T = TC1 {
        type t 'x = 'x;
      };
      T.el @@ subst (module T) p @@ T.co x
    };
};
