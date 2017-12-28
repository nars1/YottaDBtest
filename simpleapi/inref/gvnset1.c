/****************************************************************
 *								*
 * Copyright (c) 2017 YottaDB LLC. and/or its subsidiaries.	*
 * All rights reserved.						*
 *								*
 *	This source code contains the intellectual property	*
 *	of its copyright holder(s), and is made available	*
 *	under a license.  If you do not know the terms of	*
 *	the license, please stop and do not read further.	*
 *								*
 ****************************************************************/

#include "libyottadb.h"

#include <stdio.h>

#define ERRBUF_SIZE	1024

#define BADBASEVAR1 "^B%dbasevarInvChar"
#define BADBASEVAR2 "^Verylongbasevarthatexceedsmaxlength"
#define BADBASEVAR3 "^1namestartswithdigit"
#define BASEVAR "^baselv"
#define SUBSCR1	"42"
#define SUBSCR2 "answer:"
#define SUBSCR32 "x"
#define VALUE1	"A question"
#define VALUE2	"One less than 43"
#define VALUE3 	"Life, the universe, and everything"

int main()
{
	int		i, status;
	ydb_buffer_t	basevar, subscr[2], subscr32[32], value1, value2, value3, badbasevar;
	ydb_string_t	zwrarg;
	char		errbuf[ERRBUF_SIZE];

	/* Initialize varname, subscript, and value buffers */
	YDB_STRLIT_TO_BUFFER(&basevar, BASEVAR);
	YDB_STRLIT_TO_BUFFER(&subscr[0], SUBSCR1);
	YDB_STRLIT_TO_BUFFER(&subscr[1], SUBSCR2);
	YDB_STRLIT_TO_BUFFER(&value1, VALUE1);
	YDB_STRLIT_TO_BUFFER(&value2, VALUE2);
	YDB_STRLIT_TO_BUFFER(&value3, VALUE3);

	/* Note - no call to ydb_init() to verify it happens automatically */

	/* Set a base variable, no subscripts */
	status = ydb_set_s(&basevar, 0, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [1]: %s\n", errbuf);
		fflush(stdout);
		return YDB_OK;
	}
	/* Set single subscript value */
	status = ydb_set_s(&basevar, 1, subscr, &value2);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [2]: %s\n", errbuf);
		fflush(stdout);
		return YDB_OK;
	}
	/* Set two subscript value */
	status = ydb_set_s(&basevar, 2, subscr, &value3);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [3]: %s\n", errbuf);
		fflush(stdout);
		return YDB_OK;
	}
	/* Demonstrate our progress by executing a ZWRITE in a call-in */
	zwrarg.address = BASEVAR;
	zwrarg.length = sizeof(BASEVAR) - 1;
	status = ydb_ci("driveZWRITE", &zwrarg);
	if (status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("driveZWRITE error: %s\n", errbuf);
		fflush(stdout);
		return YDB_OK;
	}
	/* Now for a few error cases - first up, bad basevar names */
	printf("Attempting set of bad basevar %s\n", BADBASEVAR1);
	YDB_STRLIT_TO_BUFFER(&badbasevar, BADBASEVAR1);
	status = ydb_set_s(&badbasevar, 0, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [a]: %s\n", errbuf);
		fflush(stdout);
		/* Keep going after get expected error */
	}
	printf("Attempting set of bad basevar %s\n", BADBASEVAR2);
	YDB_STRLIT_TO_BUFFER(&badbasevar, BADBASEVAR2);
	status = ydb_set_s(&badbasevar, 0, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [b]: %s\n", errbuf);
		fflush(stdout);
		/* Keep going after get expected error */
	}
	printf("Attempting set of bad basevar %s\n", BADBASEVAR3);
	YDB_STRLIT_TO_BUFFER(&badbasevar, BADBASEVAR3);
	status = ydb_set_s(&badbasevar, 0, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [c]: %s\n", errbuf);
		fflush(stdout);
		/* Keep going after get expected error */
	}
	/* Now try sending in a non-existant subscript */
	printf("Attempting set of basevar with NULL subscript address parameter\n");
	status = ydb_set_s(&basevar, 1, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [d]: %s\n", errbuf);
		fflush(stdout);
	}
	/* Now try setting > 31 subscripts */
	printf("Attempting set of basevar with 32 subscripts\n");
	for (i = 0; i < 32; i++)
		YDB_STRLIT_TO_BUFFER(&subscr32[i], SUBSCR32);
	status = ydb_set_s(&basevar, 32, subscr32, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [e]: %s\n", errbuf);
		fflush(stdout);
	}
	/* Now try setting < 0 subscripts */
	printf("Attempting set of basevar with -1 subscripts\n");
	status = ydb_set_s(&basevar, -1, NULL, &value1);
	if (YDB_OK != status)
	{
		ydb_zstatus(errbuf, ERRBUF_SIZE);
		printf("ydb_set_s() [f]: %s\n", errbuf);
		fflush(stdout);
	}
	return YDB_OK;
}