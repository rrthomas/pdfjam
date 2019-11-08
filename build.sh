#!/bin/sh
##
## Start at top level of the repository
##
sourceDir=`pwd`
##
## First remove any old construction site
##
rm -rf build_tmp
##
## Make a new construction site
##
mkdir build_tmp build_tmp/sources
##
## Copy everything that will be needed
##
cp -r bin man1 tests COPYING VERSION pdfjam.conf README.md pdfjam-help.txt build_tmp/sources
cd build_tmp  
##
## Put the current version number in files where needed
##
version=`sed 's/^.*pdfjam\ //' sources/VERSION`
for file in sources/bin/pdf* ; 
  do cp "$file" `echo $file | sed 's/\(pdf.*\)/\1Temp/'`; rm "$file";
     sed "s/N.NN/${version}/" "$file"Temp > "$file";
     rm "$file"Temp;
     chmod a+x "$file";
done
##
## Insert the latest help text into the pdfjam script
##
sed -i -e '/pdfjam-help.txt/{r sources/pdfjam-help.txt' -e 'd}' sources/bin/pdfjam
rm sources/pdfjam-help.txt
##
## Update all the tests
##
cd sources/tests/expected\ output
for file in Prattled/test* ;
do cp "$file" `echo $file | sed 's/\(test.*\)/\1Temp/'`; rm "$file";
    sed "s/This\ is\ pdfjam\ version.*$/This\ is\ pdfjam\ version\ ${version}./" "$file"Temp > "$file";
    rm "$file"Temp;
    chmod a+r "$file";
done
cd "$sourceDir"/build_tmp/sources
rm -f tests/*/*actual-output*
rm -f tests.zip
zip -vrq tests tests -x@tests/exclude.lst
##
## Finally make two (identical) .tgz files for distribution
##
cd "$sourceDir"/build_tmp
version=`echo "$version" | sed 's/\.//'`
rm -f ../releases/pdfjam_"$version".tgz
mv sources pdfjam_"$version"
tar -c  --exclude 'tests' --exclude='.*' --exclude='*~' pdfjam_"$version" | gzip > ../releases/pdfjam_"$version".tgz 
cp ../releases/pdfjam_"$version".tgz ../releases/pdfjam_latest.tgz

