# Bene Gesselint

This is an experiment around linting OCaml code using `dune`'s `lint` field.

The idea is to expose through a library an easy way to write `lint` rules over the OCaml AST
and build a `dune` compatible lint PPX rewriter from those.

Common rules would be extracted to a library as well so they can be reused. Eventually we could
write a ready to use linter with a standard set of rules as a rewriter which one could use
directly in the `lint` field of their library or executable `dune` stanzas.
