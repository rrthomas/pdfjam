#!/bin/sh
##
## This script runs `build.sh` then creates two archive files and
## makes a GitHub release with them.
##
## Requirements: tar, zip, gh (the GitHub command-line tool)

package=pdfjam
version=$(sed 's/^.*pdfjam\ //' VERSION)
./build.sh
cd built_package
tar cvzf $package-$version.tar.gz $package-$version
zip -r $package-$version.zip $package-$version
gh release create v$version --title "Release v$version" $package-$version.zip $package-$version.tar.gz
