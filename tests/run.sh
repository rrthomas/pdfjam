#!/bin/bash

set -o pipefail -o errexit -o nounset

# Entering the parent directory of this script:
cd $(dirname ${BASH_SOURCE[0]})
if [ $# -gt 0 ]
then test_dirs="$@"
else test_dirs=$(find . -mindepth 1 -maxdepth 1 -type d)
fi
for test_dir in $test_dirs; do
    echo Executing test: $test_dir/cmd.sh...
    cd $test_dir
    if ! ./cmd.sh >actual-output.txt 2>&1; then
        cat actual-output.txt
        exit 1
    fi
    # We ignore the "Calling" log messages that contain the pdflatex cmd full path:
    diff -I' *pdfjam: *Calling .*pdflatex...' -I'/pdfjam' expected-output.txt actual-output.txt
    echo OK
    cd - >/dev/null
done
