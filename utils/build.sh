#!/bin/sh
## Run by l3build unpack
set -e
[ -n "$1" ] || { echo "Usage: $0 version"; exit 1; }
cd "$(dirname "$0")/.."
target=build/pdfjam
version="$1"

mkdir -p build/local "$target/bin" "$target/man"
[ -e build/unpacked ] && rm -r build/unpacked
ln -s pdfjam build/unpacked
cp COPYING pdfjam.conf README.md "$target"
cp pdfjam.1 "$target/man"

echo "This is pdfjam $version" >"$target/VERSION-$version"
<pdfjam sed "1,20s/N.NN/${version}/" \
	| sed -e '/pdfjam-help.txt/{r pdfjam-help.txt' -e 'd}' >"$target/bin/pdfjam"
chmod a+x "$target"/bin/pdfjam

echo "Built pdfjam $version"
