bazel query 'allpaths(//components/utilities/shopify-dl:bin, //3rdparty/jvm/org/apache/kafka:kafka_clients)' --notool_deps --output graph | dot -Tsvg > path.svg
