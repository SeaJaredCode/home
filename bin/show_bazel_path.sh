#!/usr/bin/env bash

bazel query \
    "allpaths($1, $2)" --notool_deps --output graph | dot -Tsvg > $3
