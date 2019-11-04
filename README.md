# pdfjam

_David Firth_ <http://warwick.ac.uk/dfirth>

A snapshot of this page is included as _README.md_ 
in the distributed package.  The most up-to-date version is maintained online at 
<https://github.com/DavidFirth/pdfjam>.

1. [Overview](#overview)
    - [What is pdfjam?](#whatis)
    - [Wrapper scripts no longer included here](#wrappers)
2. [Pre-requisites](#prereq)
3. [Documentation](#documentation)
4. [Installation](#install)
5. [Configuration](#config)
6. [Using pdfjam](#using)
7. [FAQ](#faq)
8. [Reporting bugs](#bugs)
9. [Version history](#history)


# <a name="overview"> Overview 

## <a name="whatis"> What is pdfjam?

The **pdfjam** package makes available the `pdfjam` shell script that provides a 
simple interface to much of the functionality of the excellent 
[pdfpages](http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages) 
package (by Andreas Matthias) for _LaTeX_. The `pdfjam` script takes one 
or more PDF files (and/or JPG/PNG graphics files) as input, and produces 
one or more PDF files as output. It is useful for joining files together, 
selecting pages, reducing several source pages onto one output page, etc., etc.

A potential drawback of `pdfjam` and other scripts based upon it is that any 
hyperlinks in the source PDF are lost. On the positive side, there is no 
appreciable degradation of image quality in processing PDF files with `pdfjam`, 
unlike some other indirect methods such as `pdf2ps|psnup|ps2pdf` 
(in the author's experience). 

`pdfjam` is designed for Unix-like systems, including Linux and Mac OS X. 
It seems that it will work also on Windows computers with a suitable 
installation of [Cygwin](http://www.cygwin.com) (with the Cygwin 
`tetex-extras` package installed), but this has not been thoroughly tested.

An alternative set of PDF manipulation tools, which are java-based, is 
provided by the [Multivalent](http://multivalent.sourceforge.net) project. 
Yet another alternative set of tools is [PDFsam](https://pdfsam.org). 
Those alternatives do much the same things as `pdfjam`, and maybe 
quite a bit more too. 

The **pdfjam** software is made available free, under GPL version 2 (see the 
file named `COPYING` that is included with the package). 
It comes with **ABSOLUTELY NO WARRANTY** of fitness for any purpose whatever.

## <a name="wrappers"> Wrapper scripts no longer included here

Previous versions of **pdfjam** (before 3.00) included some _other_ scripts too,
in addition to the `pdfjam` script iteslf.
Those other scripts are simple wrappers for calls to `pdfjam`, designed to perform 
some common tasks such as joining or n-upping PDF files or to illustrate 
other features; they are not very elaborate, and nor are they extensively tested. 
They are probably best viewed as simple templates that can be used for 
constructing more elaborate wrapper scripts as required. 

Those 'wrapper' scripts are **no longer maintained**. I continue to make 
them available in a separate repository 
<https://github.com/DavidFirth/pdfjam-extras>, 
in case anyone wants to see them, to use them, or to improve and maintain 
them independently as a separate project.

The specific wrapper scripts that were removed from the **pdfjam** package 
at version 3.00 are:

- `pdfnup`, `pdfpun`
- `pdfjoin`
- `pdf90`, `pdf180`, `pdf270`
- `pdfflip`
- `pdfbook`
- `pdfjam-pocketmod`
- `pdfjam-slides3up`, `pdfjam-slides6up`

For those scripts and for more information on them, please now see 
<https://github.com/DavidFirth/pdfjam-extras>.


# <a name="prereq"> Pre-requisites

- A Unix-like operating system (Linux, Mac OS X, FreeBSD, etc.; possibly Cygwin)
- A working, up-to-date installation of LaTeX (including at least one of 
  `pdflatex`, `lualatex` or `xelatex`)
- A working installation of the LaTeX package 
  [**pdfpages**](http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages) 
  (version 0.4f or later)
- Some of the options offered by `pdfjam` also require the LaTeX packages 
  [**geometry**](http://www.ctan.org/tex-archive/macros/latex/contrib/geometry) 
  and 
  [**hyperref**](http://www.ctan.org/tex-archive/macros/latex/contrib/hyperref).

For some years now, **pdfjam** has been included in the _TeX Live_ distribution, 
which includes all the necessary programs and packages to make `pdfjam` run smoothly.
If you have the necessary bandwidth and disk space for it, I do recommend installing 
[_TeX Live_](https://tug.org/texlive/).

# <a name="documentation"></a> Documentation

The primary documentation for `pdfjam` is obtained (after installation of `pdfjam`)
via the command

```
pdfjam --help
```

This gives information on the arguments to `pdfjam`, and the default settings 
that apply at your installation.  In addition to the arguments that are explicitly 
documented there, `pdfjam` provides access to all of the options of the 
**pdfpages** package: that's a large number of options, and it's a set of options 
that might change, so users are referred to the current 
[pdfpages manual (PDF)](http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages/pdfpages.pdf) to see what's available.

In case you want to look at the `pdfjam --help` text template online, for example
before you decide whether to install **pdfjam**, the source is available at
<https://github.com/DavidFirth/pdfjam/blob/master/pdfjam-help.txt>.

There is also a (very basic) `man` page, accessed in the usual way
(after installation) by

```
man pdfjam
```

# <a name="install"></a> Installation

There are two main ways:

1. Install the [current _TeX Live_ distribution](https://tug.org/texlive/) 
(how you do this will depend on details of your operating system).
_TeX Live_ will already contain a recent release of **pdfjam**. 
Many thanks to Karl Berry
for setting up and maintaining **pdfjam** as a _CTAN_ package that is part of 
_TeX Live_.

2.  Install it yourself (e.g., if you don't want _TeX Live_, or if you want a later
release of **pdfjam** than the one that's currently in _TeX Live_).  
Download the latest packaged release of **pdfjam** as
[pdfjam_latest.tgz](https://github.com/DavidFirth/pdfjam/raw/master/releases/pdfjam_latest.tgz).
If for some reason you don't want the latest released version, you can still get 
older versions too: see <https://github.com/DavidFirth/pdfjam/releases>.

**The first way, via _TeX Live_, is recommended** as the easiest way for most users.

If you go the second way, then you will have a bit more to do:

- The `pdfjam` shell script in the _bin_ sub-directory of the package should be 
  placed on the `PATH` of anyone who needs to use it.
- The man file in the _man1_ sub-directory should be installed on the `MANPATH` 
  of all who might need to read it.

# <a name="config"></a> Configuration

On many unix-like systems `pdfjam` should run without any further configuration, 
provided that the pre-requisite TeX installation (such as _TeX Live_) is present. 
If you want to  check (e.g., prior to installation) that `pdfjam` will work on 
your system, please unzip the _tests_ sub-directory of the package and follow 
the instructions that appear in `tests/README-tests.txt`.

If configuration _is_ needed, this can be done through a site-wide or 
user-specific configuration file. This might be necessary if, for example, your 
site has a non-standard TeX installation, or a non-standard location for 
temporary files, or a paper size that is different from the A4 international 
standard --- or some other reason.

The file 
[pdfjam.conf](https://github.com/DavidFirth/pdfjam/raw/master/sources/pdfjam.conf)
is a sample configuration file which can be edited as needed.  After editing, 
either install the file for site-wide use (at `/etc/pdfjam.conf`, 
`/usr/share/etc/pdfjam.conf`, `/usr/local/share/pdfjam.conf`, or 
`/usr/local/etc/pdfjam.conf`) or as a user-defaults file at `~/.pdfjam.conf`. 
User settings made at `~/.pdfjam.conf` override corresponding settings made 
in a site-wide configuration file.

For example, if you prefer to use `/usr/bin/xelatex` as your LaTeX engine 
(in place of the standard `pdflatex`), and you want your output page size to be
"US letter" size paper by default, you would simply include the lines 

```
pdflatex=/usr/bin/xelatex
paper=letterpaper
```

in a plain text file named  '`.pdfnup.conf`' in your home directory. 
The path `usr/bin/xelatex` specifies exactly _which_ LaTeX program will be
used: it could be a path to any one of the `pdflatex`, `lualatex` or 
`xelatex` executables.  (You can get the full path to an executable 
by, for example, the command `which xelatex`.)
The code word `letterpaper` is how LaTeX refers to that particular page size.
For other available paper sizes, and all the many 
other options that could be set as defaults if you want, please see the output of

```
pdfjam --help
```

On some systems it might even be necessary to change the list of places 
(i.e., `/etc/pdfjam.conf` and others as listed above) that is searched for 
site-wide configuration files.  This can only be done by editing the 
`pdfjam` script itself.  To see which directories on _your_ system are 
searched for a file named `pdfjam.conf`, look at the output of

```
pdfjam --configpath
```

# <a name="using"></a> Using pdfjam

For a full overview of what `pdfjam` can do, the importance of the 
[pdfpages manual (PDF)](http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages/pdfpages.pdf) 
cannot be stressed enough! 
The following examples merely serve as a brief introduction.

### Example 1: Batch 2-upping of documents

Consider converting each of two documents to a side-by-side "2-up" format. 
Since we want the two documents to be processed separately, we'll use the 
`--batch` option:

```
pdfjam --batch --nup 2x1 --suffix 2up --landscape file1.pdf file2.pdf
```

This will produce new files `file1-2up.pdf` and `file2-2up.pdf` in the current 
working directory. 

### Example 2: Merging pages from 2 documents

Suppose we want a single new document which puts together selected pages from two different files:

```
pdfjam file1.pdf '{},2-' file2.pdf '10,3-6' --outfile ../myNewFile.pdf
```

The new file `myNewFile.pdf`, in the parent directory of the current one, 
contains an empty page, followed by all pages of `file1.pdf` except the first, 
followed by pages 10, 3, 4, 5 and 6 from `file2.pdf`.

The resulting PDF page size will be whatever is the default paper size for 
you at your site. If instead you want to preserve the page size of 
(the first included page from) `file1.pdf`, use the option `--fitpaper true`.

**All pages in an output file from `pdfjam` will have the same size and 
orientation.**  For joining together PDF files while preserving _different_ page 
sizes and orientations, `pdfjam` is not the tool to use.

### Example 3: A 4-up document with frames

To make a portrait-oriented 4-up file from the pages of three input files, 
with a thin-line frame around the input pages:

```
pdfjam file1.pdf file2.pdf file3.pdf --no-landscape --frame true --nup 2x2 --suffix 4up --outfile ~/Documents
```

Here a _directory_ was specified at `--outfile`: the resultant file in this 
case will be `~/Documents/file3-4up.pdf`. 
(Note that **if there's a writeable file with that name already, it will be 
overwritten**: no check is made, and no warning given.)

### Example 4: Convert a 'US letter' document to A4

Suppose we have a document made up of 'US letter' size pages, 
and we want to convert it to A4:

```
pdfjam 'my US letter file.pdf' --a4paper --outfile 'my A4 file.pdf'
```

### Example 5: Handouts from presentation slides

A useful application of `pdfjam` is for producing a handout from a file of 
presentation slides. For slides made with the standard 4:3 aspect ratio a 
nice 6-up handout on A4 paper can be made by

```
pdfjam --nup 2x3 --frame true --noautoscale false --delta "0.2cm 0.3cm" --scale 0.95 myslides.pdf --outfile myhandout.pdf
```

The `--delta` option here comes from the pdfpages package; the `--scale` 
option is passed to LaTeX's `\includegraphics` command. 

Slides made by LaTeX's _beamer_ package, using the `handout` class option, 
work especially nicely with this! The example wrapper scripts `pdfjam-slides3up`
and `pdfjam-slides6up`, in the 
[pdfjam-extras](https://github.com/DavidFirth/pdfjam-extras) repository,
are for 3-up and 6-up handouts, respectively.

### Example 6: Trimming pages; and piped output

Suppose we want to trim the pages of our input file prior to n-upping. 
This can be done by using a pipe: 

```
pdfjam myfile.pdf --trim '1cm 2cm 1cm 2cm' --clip true --outfile /dev/stdout | pdfjam --nup 2x1 --frame true --outfile myoutput.pdf
```

The `--trim` option specifies an amount to trim from the left, bottom, right and 
top sides respectively; to work as intended here it needs also `--clip true`. 
These (i.e., `trim` and `clip`) are in fact options to LaTeX's 
`\includegraphics` command (in the standard _graphics_ package).

Thanks go to Christophe Lange and Christian Lohmaier for suggesting 
an example on this.

### Example 7: Output pages suitable for binding

To offset the content of double-sided printed pages so that they are 
suitable for binding with a 
[Heftstreifen](http://de.wikipedia.org/wiki/Heftstreifen), use 
the `--twoside` option:

```
pdfjam --twoside myfile.pdf --offset '1cm 0cm' --suffix 'offset'
```

### Example 8: Input file with nonstandard name

To use PDF input files whose names do not end in '`.pdf`', you will need to use 
the `--checkfiles` option. This depends on the availability of the `file` 
utility, with support for the options `-Lb`; this can be checked by trying

```
file -Lb 'my PDF file'
```

where `'my PDF file'` is the name of a PDF file on your system. 
The result should be something like '`PDF document, version 1.4`' 
(possibly with a different version number).

With '`file -Lb`' available, we can use PDF files whose names lack the usual 
'`.pdf`' extension.  For example, 

```
pdfnup --nup 2x1 --checkfiles 'my PDF file'
```

will result in a file named '`my PDF file-2x1.pdf`' 
in the current working directory.

### Example 9: Rotate every 2nd page

If you want to print a landscape-oriented PDF document on both sides of the paper, 
using a duplex printer that does not have 'tumble' capability, make a new version 
with every second page rotated for printing:

```
pdfjam --landscape --doublepagestwistodd true my-landscape-document.pdf
```


# <a name="faq"></a> FAQ


**1. The script runs but the output doesn't look the way it should. Why?**

Most likely either your pdfTeX or your pdfpages installation is an old version. 
You could check also that `pdftex.def`, typically to be found in 
`.../texmf/tex/latex/graphics/`, 
is up to date. If the problem persists even with up-to-date versions of pdfTeX, 
`pdftex.def` and pdfpages, then please do report it. 


# <a name="bugs"></a> Reporting bugs

Please report any bugs found in `pdfjam`, either

- by reporting as an issue at GitHub, <https://github.com/DavidFirth/pdfjam/issues>
- by email (see <http://warwick.ac.uk/dfirth> for my email address)

### Some known problems:

- Sometimes font information (such as ligatures) is lost from the output of 
  `pdfjam`.  It seems that a fairly simple fix when this happens is to add the
  option `--preamble '\pdfinclusioncopyfonts=1'` in your call to `pdfjam`.
- In _Cygwin_, using `pdfjam` in a pipeline does not seem to work. 
  The problem seems to be with _Cygwin_'s handling of file descriptors 
  within pipelines.
- The `--preamble` option can sometimes clash with other elements of the LaTeX 
  preamble.  Some specific things to watch out for:
    + If the preamble needs to set further options to the _geometry_ package, 
	  when the _geometry_ package has already been loaded in order to 
	  set a special page size, be sure to use the `\geometry{}` command for that.
    + If the preamble needs to set options to the _hyperref_ package, when 
	  the _hyperref_ package has already been loaded in order to specify PDF 
	  document information, be sure to use the `\hypersetup{}` command for that.
    + If options to the _color_ package are to be specified in the preamble, 
	  do not at the same time use the `--pagecolor` option to `pdfjam`.


# Version history

### Overview of the history

This all grew originally from a script named `pdfnup`. That was later joined,
in a published package called 'PDFjam', by two further scripts `pdfjoin` and 
`pdf90`.

At version 2.00, everything was unified through a single script `pdfjam`, with
many more options. Along with `pdfjam` various 'wrapper' scripts --- i.e., 
other scripts that use `pdfjam` in different ways --- were provided, mainly as
examples.

From version 3.00, the extra 'wrapper' scripts are removed from the package,
mainly because they are hard to maintain: different users want different
things, and `pdfjam` itself provides all the options in any case. So I have
broken out the wrapper scripts into a separate repository, _unsupported_ ---
so that people can still see and use/adapt them if they want. 
And maybe even someone else will 
want to take on the task of improving and maintaining some of them,
who knows?  The wrapper scripts (**no longer maintained**) can now be found at 
<https://github.com/DavidFirth/pdfjam-extras>.


### Version release notes

**3.00** [in development]: 

- Re-styled the package name to **pdfjam**. (Previously the package --- which then
  contained several scripts --- was named PDFjam).
- Moved everything to a new home on the web at 
  <a href="https://github.com/DavidFirth">github.com/DavidFirth</a>.
- Simplified the package by removal of all the 'wrapper' scripts 
  (`pdfnup`, `pdfjoin`, etc.).
- Settings specified via `--preamble` are now protected from the normal 
  tidying of the TeX input file to remove redundant packages. 

**2.09** [never released]:

- The default behaviour of `pdfbook` is reverted to its pre-2.06 state, 
  because `--booklet true` seems to be problematic for some users.

**2.08** [2010-11-14]: 

- Fixed a bug in one of the tests. 

**2.07** [2010-11-13]: 

- Two other common graphics formats (JPG and PNG) are now explicitly 
  allowed as input files (i.e., not only PDF files are allowed as inputs). 

**2.06** [2010-05-11]: 

- Changed the `pdfbook` script to include `--booklet true` as the 
  default behaviour (thanks to Julien Bossert for this good suggestion). 

**2.05** [2010-04-25]: 

- Changes to the `pdfbook` script [the `--right-edge-binding` option is 
  now redundant, and there's a new `--short-edge` option for binding along the 
  short edge of pages instead of the long edge (thanks to Marco Pessotto for this).
- The `--preamble` option to `pdfjam` is enhanced, to allow multiple instances 
  which get concatenated. 
- Also various minor corrections to man pages.

**2.04** [2010-04-22]: 

- Various minor improvements suggested by Debian maintainers 
  (thanks to Eduard Bloch for these). The main things are: 
    + addition of the `--version` option; 
	+ liberalisation of `pdfjam` to allow files in _JPEG_ format to be 
	  specified as input, as well as PDF; 
	+ tidying of the man files; 
	+ and more use of `exec`, to avoid forking.

**2.03** [2010-04-20]: 

- Fixed a bug which caused problems when your `/bin/sh` is the _zsh_ shell.
- Fixed a bug which prevented the correct representation of many UTF-8 characters 
  in `pdfinfo` data.

**2.02** [2010-04-14]: 

- More progress on portability.
- Introduced the beginnings of a suite of tests. 
- Iimprovements in the `--keepinfo` functionality, and in the treatment of 
  file permissions (thanks to Marco Pessotto for these).

**2.01** [2010-04-13]: 

- Fixed a silly bug (thoughtless use of "`test -a`" in a couple of places) 
  which seriously affected portability.

---------------------------------------------------------------
 
**2.00** [2010-03-14]: **a major re-design**

This is not completely backward-compatible with previous versions of the 
`pdfnup`, `pdfjoin` and `pdf90` scripts. 
The differences in interface are few, though, and the main ones are 
listed below.

- The new script `pdfjam` now does all the work; all the other scripts 
  included with the package are just simple wrappers for `pdfjam`. 
- New `pdfjam` makes available essentially _all_ of the facilities of the 
  pdfpages package (without having to know what they are). 
- Various security and portability issues have been resolved. 
  (None of the scripts now calls for `/bin/bash`; and the handling of 
  temporary files is now much safer.) 
- `pdfjam` can take PDF input from `/dev/stdin`, and send output to 
  `/dev/stdout`. (This allows `pdfjam` to be used in a pipeline.) 
- If the `--outfile` option specifies a relative path, that path is now 
  relative to the _current working directory_ (as is normally expected of 
  unix utilities). **This is different behaviour from previous versions.** 
- With multiple input files, `pdfjam` offers two distinct methods of processing.
  **This is different behaviour from previous versions.** 
    1. The default is to take pages as specified from the input files, and 
	  combine them into a single document. 
	2. If the `--batch` option is used, `pdfjam` operates _separately_ on the 
	  input files, producing one output file per input file. 
- Page selection is available separately for each input file. A 
  **difference from previous versions** is that the `--pages` keyword is no 
  longer used. 
- `pdfjam` uses the `\includepdfmerge` command from _pdfpages_, as a result 
  of which all pages in an output file have the same size and orientation. 
  **This is different behaviour from previous versions.** 
- Output page orientation is now controlled by using `--landscape` (negated, 
  if necessary, by `--no-landscape`). The previous `--orient` option is no 
  longer used, and in particular "`--orient auto`" is no longer available. 
  **This is different behaviour from previous versions.**
- Other new features include: 
    + `--keepinfo` option, to allow preservation of PDF document information, 
		if the `pdfinfo` utility and the LaTeX `hyperref` package are 
		available (thanks to Robert Wenner for suggesting this); 
    + `--pdftitle`, `--pdfauthor`, `--pdfsubject` and `--pdfkeywords` 
		options, to specify new PDF document information 
		(these require the LaTeX `hyperref` package); 
    + many more "named" output page sizes are available if the LaTeX 
		`geometry` package is installed (the full list of allowed paper 
		specifications is: `a0paper, a1paper, a2paper, a3paper, a4paper, 
		a5paper, a6paper b0paper, b1paper, b2paper, b3paper, b4paper, 
		b5paper, b6paper letterpaper, executivepaper, legalpaper`; 
		thanks to Corné Verbruggen and Mel Irizarry for suggesting this) and 
		non-standard page sizes can also be defined; 
    + `--checkfiles` option to request that input files be checked using the 
		`file` utility, rather than requiring the file name to end in 
		"`.pdf`" or "`.PDF`"; 
    + `--twoside` option, to allow the LaTeX _twoside_ class option to be 
		specified (thanks to Johannes Reinhard for suggesting this); 
    + `--pagecolor` option, to allow the background colour of output pages 
		to be changed (thanks to James Fisher for suggesting this); 
    + `--vanilla` option to run `pdfjam` without reading site-wide or user 
		configuration files. 
- In addition, various reported bugs have been fixed — many thanks to all 
  those kind people who reported them.

---------------------------------------------------------------
 
**1.21** [2009-01-19]: 
 
- Bug fixes, including security issues (many thanks to Eduard Bloch, 
  Robert Buchholz and Martin Vaeth for helpful reports on vulnerabilities and 
  for kindly contributing patches). 
- The scripts now call for `/bin/bash` as interpreter.
- Availability of `mktemp` is now also assumed. 
- The Mac OS X droplets now look for `pdflatex` at (by default) 
  `/usr/texbin/pdflatex`

**1.20** [2005-01-25]

- Added minimal man pages. 
- Added extra possible locations for the site-wide configuration file. 

**1.11** [2004-10-13]: 
 
- Added the `--scale` option to `pdfnup`, which allows page margins either to 
  be enlarged (e.g,. `--scale 0.9`) or reduced (e.g,. `--scale 1.1`) by 
  scaling the page contents. By popular request!  

**1.10** [2004-06-24]: 
 
- Output files now appear by default in same directory as input, rather than in 
  the current working directory; fixed a bug that caused the scripts not to work 
  on some versions of Solaris (thanks to Daniel Gebhart); major improvements to 
  the Mac OS X sample droplets.

**1.03** [2004-05-09]: 

- Minor changes towards POSIX compliance. 

**1.02** [2004-05-08]: 

- Added a COPYING file to the package. 

**1.00** [2004-05-07]: 

- Package re-named PDFjam. 

**0.99a** [2004-05-06]: 

- A minor change to the output of `pdfnup --help` and `pdfjoin --help` 

**0.99** [2004-05-05]: 

- Various improvements to `pdfnup`, including the handling of multiple PDF 
input files. Added `pdfjoin` and `pdf90`. 

**0.97** [2004-04-23]: 

- Corrections to the output of `pdfnup --help`. 

**0.96** [2004-02-12]: 

- Minor changes to comments in the `pdfnup` script. 

**0.95** [2004-01-28]: 

- Added the possibility of site-specific and user-specific configuration 
  files (thanks to Jason Lewis for suggesting this). 

**0.9** [2004-01-28]: 

- Added `--openright` (thanks to Jason Lewis for suggesting this). 

**0.8** [2003-09-12]: 
 
- Added `pdfnup --help` facility (thanks to Wilfrid Kendall for this suggestion). 

**0.7** [2003-01-26]: 

- Paths involving spaces now permitted.
- Page trimming added (thanks to Alex Montgomery for suggesting that). 
- Default output filename now has a dash inserted before the "nup" label 
  (as in ` wasteful-2x2.pdf `). 
- Sample Mac OS X droplets provided. 

**0.6** [2002-08-22]: 

- Use of paths involving spaces now reports an error. 

**0.5** [2002-06-24]: 

- Fixed a bug which caused incompatibility with some types of unix. 

**0.4** [2002-04-30]: 
 
- Better error trapping, improved portability. 

**0.3** [2002-04-04]: 
 
- First public release of `pdfnup`. 


