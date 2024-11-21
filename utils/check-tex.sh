#!/bin/sh
cd "$(dirname "$(dirname "$0")")"
l3build check -ccheck-tex && exit
errorcode=$?
cd build/test-check-tex
for i in *.diff; do
    echo "=== $i ==="
    cat "$i"
    echo
    t=${i%.diff}
    echo "=== $t.log ==="
    cat "${t##*.engine-}/${t%.engine-*}.d/a.log"
    echo
done
exit $errorcode
