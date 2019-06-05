# Bene Gesselint

This is an experiment around linting OCaml code using `dune`'s `lint` field.

The idea is to expose through a library an easy way to write `lint` rules over the OCaml AST
and build a `dune` compatible lint PPX rewriter from those.

Common rules would be extracted to a library as well so they can be reused. Eventually we could
write a ready to use linter with a standard set of rules as a rewriter which one could use
directly in the `lint` field of their library or executable `dune` stanzas.

## The `bene-gesselint` library

*This an experimental/alpha version*

It allows you to write lint rules for expressions and to apply them via dune.

An example is available in the `example/` folder where we define a custom linter as a PPX rewriter
in `linter.ml` using the `bene-gesselint` library.

It contains a single rule that detects additions of two static integer and suggests to replace them
by the sum directly.

This custom linter can be applied to the example library through `dune build @lint` thanks to
the `(lint (pps linter))` field of `example_lib` library stanza which should be pick up the static
addition in the `print_five` function and suggest a replacement as follows:
```
$ dune build @lint
Done: 33/35 (jobs: 1)File "example/example_lib.ml", line 1, characters 0-0:
        diff (internal) (exit 1)
(cd _build/default && /usr/bin/diff -u example/example_lib.ml example/example_lib.ml.lint-corrected)
--- example/example_lib.ml	2019-06-05 19:30:04.303191975 +0200
+++ example/example_lib.ml.lint-corrected	2019-06-05 19:40:55.162967194 +0200
@@ -1 +1 @@
-let print_five = print_int (2 + 3)
+let print_five = print_int 5
```

`dune build @lint` uses dune promotion system which means the changes suggest by the custom linter
can be applied with `dune promote` or the `--auto-promote` flag.
