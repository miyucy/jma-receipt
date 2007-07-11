#include <stdio.h>
#include <syslog.h>

void
cobabort (char *message)
{
	fprintf(stderr, "cobabort: %s\n", message);
	syslog(LOG_ERR, message);
	exit(2);
}
