To test whether pdfjam runs correctly on your system:

 ** cd to the "tests" sub-directory of the package (where this file lives)
 ** execute the command
      ./run.sh

This simply runs pdfjam on a few small test files, and writes results in a 
sub-directory named "actual output".  If all is well, you should just see 
"OK" reported for all of the examples.  Otherwise something is not quite right.

If after you have checked all of the pre-requisites there are still differences 
reported between the actual and expected outputs from the tests, please
report the problem (please see http://go.warwick.ac.uk/pdfjam for contact 
details).  When making such a report it is helpful to provide information
about your operating system and what shell you use as /bin/sh. 

(Note to Cygwin users: "TEST 3" will fail in current versions of Cygwin, 
because Cygwin seems to handle file descriptors differently when pipelines 
are used.  This is a known problem: please don't report it unless you have 
worked out how to fix it.)

Thanks!
David Firth
