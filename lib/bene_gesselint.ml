open Ppxlib
module Rule = Rule

let expr_rule_iterator rule =
  object
    inherit Ast_traverse.iter as super

    method! expression expr =
      Rule.apply ~loc:expr.pexp_loc rule expr;
      super#expression expr
  end

let impl_from_rule rule =
  let iterator = expr_rule_iterator rule in
  fun structure ->
    iterator#structure structure;
    structure

let apply_rule rule = Driver.register_transformation ~impl:(impl_from_rule rule) "lint"
