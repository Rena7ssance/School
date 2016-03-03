default : all;

run : test;

test : all
	(make -C kernel kernel.img)
	expect e0.tcl | grep -v sgabios > test.out
	@((diff -bB test.ok test.out > test.diff 2>&1) && echo "pass") || (echo "*** failed ***"; echo "\n========\nexpected\n========\n\n"; cat test.ok ; echo "\n\n========\nfound\n========\n\n" ; cat test.out ; echo "\n\n================\nfailed"; echo "expected results in test.ok" ; echo "your results in test.out";echo "================")

	
% :
	(make -C kernel $@)
