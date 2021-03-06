#!/usr/local/bin/tcsh -f
#################################################################
#								#
# Copyright (c) 2017-2018 YottaDB LLC. and/or its subsidiaries.	#
# All rights reserved.						#
#								#
#	This source code contains the intellectual property	#
#	of its copyright holder(s), and is made available	#
#	under a license.  If you do not know the terms of	#
#	the license, please stop and do not read further.	#
#								#
#################################################################
#
#-------------------------------------------------------------------------------------
# List of subtests of the form "subtestname [author] description"
#-------------------------------------------------------------------------------------
# zindcacheoverflow [ashok] Test fix to indirect code cache stats 4-byte overflow error
# largelvarray      [nars]  Test local array performance does not deteriorate exponentially with large # of nodes
# gctest            [nars]  Test stringpool garbage collection performance with lots of strings in the pool
# patnotfound       [nars]  Test runtime behavior after PATNOTFOUND compile-time error
# readtimeout       [nars]  Test that READ X:TIMEOUT works correctly if TIMEOUT is a fraction with more than 3 decimal digits
# miximage          [nars]  Test MIXIMAGE error is appropriately issued when multiple images are mixed in same process
# zeofprocfs        [nars]  Test that $ZEOF is correctly set after READ commands on procfs files (e.g. /proc/$J/io)
# libyottadb        [nars]  Test that libgtmshr.so/libgtmutil.so are soft links to libyottadb.so/libyottadbutil.so
# zstepoveroutof    [nars]  Test that ZSTEP OVER and ZSTEP OUTOF work if an extrinsic function returns using QUIT @ syntax
# msgprefix         [nars]  Test of <ydb_msgprefix> environment variable
# ydbdist           [nars]  Test of <ydb_dist/gtm_dist> env vars and how they affect how executables in $ydb_dist are invoked
# divzero           [nars]  Test that division by zero issues DIVZERO error and not SIGINTDIV
# readonly_dbflag   [nars]  Test various issues identified with the READ_ONLY db characteristic (new feature in GT.M V6.3-003)
# readcmdrecallhist [nars]  Test recall history for M READ command
# nestedtriggers    [nars]  Test nested trigger reloads and TP restarts in multi-process setup
# ctrlchandler      [nars]  Test that Device exception handlers are dispatched when Ctrl-C is entered
# ydb_gbldir        [nars]  Test for new ydb_gbldir env var
# ydb_maxtptime     [nars]  Test for new ydb_maxtptime env var
# ydb_dbglvl        [nars]  Test for new ydb_dbglvl env var
# callgassert       [nars]  Test an assert in CALLG.C line 96 for expression (fnptr == (callgfnptr)push_parm)
#-------------------------------------------------------------------------------------

echo "r120 test starts..."

# List the subtests separated by spaces under the appropriate environment variable name
setenv subtest_list_common     ""
setenv subtest_list_non_replic "zindcacheoverflow largelvarray gctest patnotfound readtimeout miximage zeofprocfs"
setenv subtest_list_non_replic "$subtest_list_non_replic libyottadb zstepoveroutof msgprefix ydbdist divzero"
setenv subtest_list_non_replic "$subtest_list_non_replic readonly_dbflag readcmdrecallhist nestedtriggers"
setenv subtest_list_non_replic "$subtest_list_non_replic ctrlchandler ydb_gbldir ydb_maxtptime ydb_dbglvl"
setenv subtest_list_non_replic "$subtest_list_non_replic callgassert"
setenv subtest_list_replic     ""

if ($?test_replic == 1) then
	setenv subtest_list "$subtest_list_common $subtest_list_replic"
else
	setenv subtest_list "$subtest_list_common $subtest_list_non_replic"
endif

# Use $subtest_exclude_list to remove subtests that are to be disabled on a particular host or OS
setenv subtest_exclude_list	""

# Disable certain heavyweight tests on single-cpu systems
if ($gtm_test_singlecpu) then
	setenv subtest_exclude_list "$subtest_exclude_list largelvarray"
endif

# Disable certain time-sensitive tests on single-cpu systems as it uses expect (a terminal and interactive activity)
if ($gtm_test_singlecpu) then
	setenv subtest_exclude_list "$subtest_exclude_list readtimeout"
endif

if ("dbg" == "$tst_image") then
	# gctest subtest stresses the stringpool garbage collection and runs very slow in dbg so disable it there.
	setenv subtest_exclude_list "$subtest_exclude_list gctest"
endif

# Submit the list of subtests
$gtm_tst/com/submit_subtest.csh

echo "r120 test DONE."
