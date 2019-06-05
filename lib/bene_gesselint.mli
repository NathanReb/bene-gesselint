open Ppxlib

module Rule : sig
  (** The type for a lint rewriting rule. ['ast_node] is the type of AST fragment to which the rule apply
      and ['rewrite] is the type of the function that is used to produce the rewriting suggestion for
      the rule infringing AST part.

      Linting rules are built using [Ppxlib]'s [Ast_pattern] module. ['rewrite] is the type of the pattern
      continuation. Its return type must be a string, and in particular that string must be the rewritten
      "bad" AST node, pretty printed as OCaml code. *)
  type ('ast_node, 'rewrite) t

  val make :
    pattern:('ast_node, 'rewrite, string) Ast_pattern.t ->
    rewrite:'rewrite ->
    unit ->
    ('ast_node, 'rewrite) t
end

val apply_rule : (expression, 'rewrite) Rule.t -> unit
