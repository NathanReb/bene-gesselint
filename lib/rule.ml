open Ppxlib

type ('ast_node, 'rewrite) t = {
  pattern : ('ast_node, 'rewrite, string) Ast_pattern.t;
  rewrite : 'rewrite
}

let make ~pattern ~rewrite () = { pattern; rewrite }

let apply ~loc t node =
  let iter_pattern =
    Ast_pattern.map_result ~f:(fun repl -> Driver.register_correction ~loc ~repl) t.pattern
  in
  Ast_pattern.parse iter_pattern loc ~on_error:(fun () -> ()) node t.rewrite
