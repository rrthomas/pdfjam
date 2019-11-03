#!/bin/sh
sourceDir=`pwd`
rm -rf build
mkdir build
cp -r ./sources build
cp ./README.md build/sources
cd build  
version=`sed 's/^.*pdfjam\ //' sources/VERSION`
for file in sources/bin/pdf* ; 
  do cp "$file" `echo $file | sed 's/\(pdf.*\)/\1Temp/'`; rm "$file";
     sed "s/N.NN/${version}/" "$file"Temp > "$file";
     rm "$file"Temp;
     chmod a+x "$file";
done
cd sources/tests/expected\ output
for file in Prattled/test* ;
do cp "$file" `echo $file | sed 's/\(test.*\)/\1Temp/'`; rm "$file";
    sed "s/This\ is\ pdfjam\ version.*$/This\ is\ pdfjam\ version\ ${version}./" "$file"Temp > "$file";
    rm "$file"Temp;
    chmod a+r "$file";
done
cd "$sourceDir"/build/sources
rm -rf 'tests/actual output'
rm -f tests.zip
zip -vrq tests tests -x@tests/exclude.lst
## Make the .tgz file for distribution
##
cd "$sourceDir"/build
version=`echo "$version" | sed 's/\.//'`
rm -f ../releases/pdfjam_"$version".tgz
mv sources pdfjam_"$version"
tar -c  --exclude 'tests' --exclude='.*' --exclude='*~' pdfjam_"$version" | gzip > ../releases/pdfjam_"$version".tgz 
cp ../releases/pdfjam_"$version".tgz ../releases/pdfjam_latest.tgz
