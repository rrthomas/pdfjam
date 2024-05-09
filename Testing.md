# Testing pdfjam

In the absence of automated tests, here is a manual test procedure that tests some basic functionality, mostly to do with page sizes.

All of the below is run from the directory `built_package/pdfjam-3.xx` after running `build.sh`.

The file `test.pdf` is a single page of A5.


## 1.  First with libpaper’s default paper size (A4).  No pdfjam config file anywhere.

### Check that `--help` shows the expected defaults:
```
$ ./bin/pdfjam --help
```
Output should include:
```
     --paper PAPERSPEC  (or simply --PAPERSPEC)
                  Specify a LaTeX paper size, for example
                  '--paper a4paper' or simply '--a4paper' for ISO A4 paper.
                  A wide range of paper sizes is available thanks to the
                  LaTeX 'geometry' package.  For details see documentation
                  for LaTeX and/or the 'geometry' package.
                  [Default for you at this site: paper=]
     --papersize '{WIDTH,HEIGHT}'
                  Specify a custom paper size, e.g.,
                      --papersize '{10in,18cm}'
                  (Note the braces, and the comma!)
                  [Default for you at this site: papersize={210mm,297mm}]
```


### Check that the default gets used as expected:
```
$ ./bin/pdfjam ../../test.pdf
```
Should produce A4 (from default as shown above).

### Check whether `--landscape` works as expected:
```
$ ./bin/pdfjam --landscape ../../test.pdf
```
Should produce landscape A4. 

### Check whether `--fitpaper true` works as expected:
```
$ ./bin/pdfjam --fitpaper true ../../test.pdf
```
Should produce A5 output.

### Check whether LaTeX paper spec works as expected:
```
$ ./bin/pdfjam --a5paper ../../test.pdf
```
Should produce A5 output.

```
$ ./bin/pdfjam --landscape --a5paper ../../test.pdf
```
Should produce landscape A5 output.


## What happens if there is no `paper` in my path?

Remove or uninstall libpaper temporarily to test this.

The following should deliver, respectively, an A4 portrait and an A4 landscape document.
```
$ ./bin/pdfjam ../../test.pdf
$ ./bin/pdfjam --landscape ../../test.pdf
```

## 2. Now, still with no pdfjam config file anywhere.  But I happen to have an executable called `paper`, which is nothing to do with _libpaper_, higher in my path.
```
$ which paper
~/bin/paper
$ cat ~/bin/paper
#!/bin/sh
echo 'A4'
exit
```

### Check that pdfjam ignores this other `paper`
```
$ ./bin/pdfjam --help
...
The 'paper' program seems not to be working; not using it
...
```

## 3.  Now look at whether _pdfjam_ configuration files are treated as expected

This only tests the use of a configuration file at `~/.pdfjam.conf`.  The only setting I made there was to specify `paper='letterpaper'`.

### Check the defaults as reported now by `pdfjam --help`
```
     --paper PAPERSPEC  (or simply --PAPERSPEC)
                  Specify a LaTeX paper size, for example
                  '--paper a4paper' or simply '--a4paper' for ISO A4 paper.
                  A wide range of paper sizes is available thanks to the
                  LaTeX 'geometry' package.  For details see documentation
                  for LaTeX and/or the 'geometry' package.
                  [Default for you at this site: paper=letterpaper]
     --papersize '{WIDTH,HEIGHT}'
                  Specify a custom paper size, e.g.,
                      --papersize '{10in,18cm}'
                  (Note the braces, and the comma!)
                  [Default for you at this site: papersize=]
```


### Check that the defaults are applied as expected
```
$ ./bin/pdfjam ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam  -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```

Should produce portrait US letter output.

### Check whether `--landscape` works as expected
```
$ ./bin/pdfjam --landscape ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam --landscape -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```

Should produce landscape US Letter output.

### Check whether `--fitpaper true` works as expected
```
$ ./bin/pdfjam --fitpaper true ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam --fitpaper 'true' -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```

Should produce portrait US Letter output.

### Check that command-line use of a LaTeX paper spec works as expected
```
$ ./bin/pdfjam --letterpaper ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam --letterpaper -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```

Should produce portrait US Letter output.

```
$ ./bin/pdfjam --a5paper ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam --a5paper -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```
Should produce portrait A5 output.

```
$ ./bin/pdfjam --landscape --a5paper ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam --landscape --a5paper -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```
Should produce landscape A5 output.

### Check what happens if there is no `paper` in the PATH

Again, I temporarily moved aside the `paper` executable.

```
$ ./bin/pdfjam ../../test.pdf
          ----
  pdfjam: This is pdfjam version x.yy.
  pdfjam: Reading any site-wide or user-specific defaults...
              ## 
              ## From /home/david/.pdfjam.conf: 
              ##
              paper='letterpaper'
  pdfjam: Effective call for this run of pdfjam:
          ./bin/pdfjam  -- ../../test.pdf - 
  pdfjam: Calling /usr/bin/pdflatex...
  pdfjam: Finished.  Output was written to '/home/david/pdfjam-x.yy/test-pdfjam.pdf'.
```
Should produce portrait US Letter output.
