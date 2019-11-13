#!/bin/sh
##
## This script works in the pdfjam source directory, to create a subdirectory
## named "built_package" that contains a finished package ready for distribution.
##
## The "finished" package (a subdirectory of "built_package") has:
##   -- the current version number (in the pdfjam script itself, in
##      the expected outputs from tests, and in the package name);
##   -- the text needed for 'pdfjam --help' inserted in the pdfjam script;
##
## -----------------------------------------------------------------------------
##
## First remove any old construction site
##
rm -rf built_package
##
## Make a new construction site
##
mkdir built_package built_package/sources
##
## Copy everything that will be needed
##
cp -r bin man1 tests COPYING VERSION pdfjam.conf README.md pdfjam-help.txt built_package/sources
cd built_package  
##
## Put the current version number in the pdfjam script
##
version=$(sed 's/^.*pdfjam\ //' sources/VERSION)
sed -i "s/N.NN/${version}/" sources/bin/pdfjam
chmod a+x sources/bin/pdfjam;
##
## Insert the latest help text into the pdfjam script
##
sed -i -e '/pdfjam-help.txt/{r sources/pdfjam-help.txt' -e 'd}' sources/bin/pdfjam
rm sources/pdfjam-help.txt
##
## Update all the tests
##
cd sources/tests
test_dirs=$(find . -mindepth 1 -maxdepth 1 -type d)
for test_dir in $test_dirs; do
    sed -i "s/This\ is\ pdfjam\ version.*$/This\ is\ pdfjam\ version\ ${version}./" "$test_dir"/expected-output.txt
done    
##
## Finally rename the built package with the current version number
##
cd ../..
mv sources pdfjam-"$version"
