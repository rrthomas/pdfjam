To test whether pdfjam runs correctly on your system:

    tests/run.sh

This simply runs pdfjam on a few small test files, and writes results in a 
sub-directory named "actual_output". If all is well, you should just see 
"OK" reported for all of the examples. Otherwise something is not quite right,
and the command will exist with a non-0 status code.

You can also execute a single test this way:

    tests/run.sh test1

If after you have checked all of the pre-requisites there are still differences 
reported between the actual and expected outputs from the tests, please
report the problem on https://github.com/rrthomas/pdfjam/issues .
When making such a report it is helpful to provide information
about your operating system and what shell you use as /bin/sh. 
