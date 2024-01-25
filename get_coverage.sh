#!/usr/bin/env bash

# Displays unit test code coverage in a local html file using genhtml and dart test_with_coverage
#
# Example usage: `./get_coverage.sh core`
# Runs unit tests for the core package and displays coverage.

pushd $1
dart pub global run coverage:test_with_coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
popd