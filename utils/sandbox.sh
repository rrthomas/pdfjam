#!/bin/sh
cd "$(dirname "$0")/.."

mkdir -p build/bin
rm -f build/bin/*
for i in awk basename cat cp cut dirname file grep iconv kpsewhich ln lualatex mkdir mv od paperconf pdfinfo pdflatex realpath rm sed tee tr tty uname xelatex; do
	ln -s "$(command -v $i)" build/bin/$i || { echo "No $i command found. Something is seriously amiss."; exit 1; }
done

rm -fr build/bin/libpaper/
mv build/bin/paperconf build/bin/libpaper/
