let static_add_rule =
  let pattern =
    let open Ppxlib.Ast_pattern in
    pexp_apply
      (pexp_ident (lident (string "+")))
      (no_label (eint __) ^:: no_label (eint __) ^:: nil)
  in
  let rewrite i1 i2 = string_of_int (i1 + i2) in
  Bene_gesselint.Rule.make ~pattern ~rewrite ()

let () = Bene_gesselint.apply_rule static_add_rule
