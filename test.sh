#!/bin/zsh

otool_l_bundle() {
    target="$1"
    test_bundle_path=$(find bazel-out/ -name "NonDeterministicBundlesTests.__internal__.__test_bundle_bin")
    otool -l "$test_bundle_path" > "$target"
}

bazelisk clean --expunge
bazelisk test \
    --xcode_version=14.2.0 \
    --disk_cache= \
    --experimental_execution_log_file="test_log1"  \
    :NonDeterministicBundlesTests

otool_l_bundle "bundle_1_otool_l"

bazelisk clean --expunge
bazelisk test \
    --xcode_version=14.2.0 \
    --disk_cache= \
    --experimental_execution_log_file="test_log2"  \
    :NonDeterministicBundlesTests

otool_l_bundle "bundle_2_otool_l"

# Make sure path to the parser is adjusted
bazel-master/bazel-bin/src/tools/execlog/parser \
    --log_path test_log1 \
    --log_path test_log2 \
    --output_path test_log1_parsed \
    --output_path test_log2_parsed

