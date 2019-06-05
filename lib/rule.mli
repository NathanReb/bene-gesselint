open Ppxlib

type ('ast_node, 'rewrite) t

val make :
  pattern:('ast_node, 'rewrite, string) Ast_pattern.t ->
  rewrite:'rewrite ->
  unit ->
  ('ast_node, 'rewrite) t

val apply : loc:Location.t -> ('ast_node, 'rewrite) t -> 'ast_node -> unit
