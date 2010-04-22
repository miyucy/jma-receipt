#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>

void
cobabort (char *message)
{
	fprintf(stderr, "cobabort: %s\n", message);
	syslog(LOG_ERR, "%s", message);
	exit(2);
}
